# Why (2026-10-02): derived table on purpose. The metric needs two
# per-booking aggregations (first refund task, summed refund tax) before
# they are joined; joining the raw tables would repeat the tax once per
# task. Requested to back a tile on dashboard 1752 after Looker refused
# to save the same query from SQL Runner.
#
# One row per refunded booking and refund-line currency. A booking counts
# once, on the day of its first refund task. Tax stays in the refund-line
# currency: no conversion, because bookings.exchange_rate converts into the
# booking currency, not into USD. Never sum tax across currencies; group or
# pivot by currency. Bookings with a refund task but no matching refund line
# get one row with a NULL currency and NULL tax.
view: wenrix_refunds {
  derived_table: {
    sql:
      SELECT
        t.booking_id,
        t.refund_processed_at,
        r.currency,
        -r.refunded_tax AS refunded_tax
      FROM (
        SELECT bt.booking_id, MIN(bt.create_date) AS refund_processed_at
        FROM booking_tasks bt
        JOIN bookings b ON b.id = bt.booking_id AND b.is_test = 0
        WHERE bt.type = 109
          AND bt.note NOT LIKE '%CORRECTION%'
          AND bt.create_date > '2026-09-23 12:22:40'
        GROUP BY bt.booking_id
      ) t
      LEFT JOIN (
        SELECT booking_id, currency, SUM(tax) AS refunded_tax
        FROM booking_statement_items
        WHERE type = 'fare'
          AND transaction_type = 'refund'
          AND payment_processor = 'agency'
          AND status != 'deleted'
          AND create_date > '2026-09-23 12:22:40'
        GROUP BY booking_id, currency
      ) r ON r.booking_id = t.booking_id ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${booking_id}, '-', COALESCE(${currency}, 'none')) ;;
  }

  dimension: booking_id {
    type: number
    description: "Booking with at least one refund task (type 109, not a correction)."
    sql: ${TABLE}.booking_id ;;
  }

  dimension: currency {
    type: string
    label: "Refund Currency"
    description: "Currency of the refund lines. Empty when the booking has no matching refund line."
    sql: ${TABLE}.currency ;;
  }

  dimension_group: refund_processed {
    type: time
    timeframes: [raw, date, week, month]
    description: "Time of the booking's first refund task."
    sql: ${TABLE}.refund_processed_at ;;
  }

  dimension: refunded_tax {
    hidden: yes
    type: number
    sql: ${TABLE}.refunded_tax ;;
  }

  measure: booking_count {
    type: count_distinct
    label: "Booking Count"
    description: "Refunded bookings, counted once each."
    sql: ${booking_id} ;;
  }

  measure: total_refunded_tax {
    type: sum
    label: "Total Refunded Tax"
    description: "Agency fare refund tax in the refund-line currency, shown as a positive number. Only meaningful when grouped or pivoted by Refund Currency."
    sql: ${refunded_tax} ;;
    value_format_name: decimal_2
  }
}
