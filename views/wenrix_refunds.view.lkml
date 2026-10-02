# Why (2026-10-02): derived table on purpose. The metric needs two
# per-booking aggregations (first refund task, summed refund amount) before
# they are joined; joining the raw tables would repeat the amount once per
# task. Requested to back a tile on dashboard 1752 after Looker refused
# to save the same query from SQL Runner.
#
# One row per refunded booking and refund-line currency. A booking counts
# once, on the day of its first refund task. Multi-ticket pairs count as
# their master booking: slave tasks and slave refund lines are mapped to the
# master, because the refund can be recorded on the slave while the task
# sits on the master. Amount is SUM(internal_amount) in the refund-line
# currency, with no conversion (bookings.exchange_rate converts into the
# booking currency, not into USD). Never sum amounts across currencies;
# group or pivot by currency. Bookings with a refund task but no matching
# refund line get one row with a NULL currency and NULL amount.
view: wenrix_refunds {
  derived_table: {
    sql:
      SELECT
        t.booking_id,
        t.refund_processed_at,
        r.currency,
        -r.refunded_amount AS refunded_amount
      FROM (
        SELECT
          CASE WHEN b.multiticket_relationship_type = 'slave'
               THEN b.multiticket_related_booking_id ELSE b.id END AS booking_id,
          MIN(bt.create_date) AS refund_processed_at
        FROM booking_tasks bt
        JOIN bookings b ON b.id = bt.booking_id AND b.is_test = 0
        WHERE bt.type = 109
          AND bt.note NOT LIKE '%CORRECTION%'
          AND bt.create_date > '2026-09-23 12:22:40'
        GROUP BY 1
      ) t
      LEFT JOIN (
        SELECT
          CASE WHEN b.multiticket_relationship_type = 'slave'
               THEN b.multiticket_related_booking_id ELSE b.id END AS booking_id,
          bsi.currency,
          SUM(bsi.internal_amount) AS refunded_amount
        FROM booking_statement_items bsi
        JOIN bookings b ON b.id = bsi.booking_id
        WHERE bsi.type = 'fare'
          AND bsi.transaction_type = 'refund'
          AND bsi.payment_processor = 'agency'
          AND bsi.status != 'deleted'
          AND bsi.create_date > '2026-09-23 12:22:40'
        GROUP BY 1, 2
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
    description: "Booking with at least one refund task (type 109, not a correction). Multi-ticket pairs show the master booking."
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

  dimension: refunded_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.refunded_amount ;;
  }

  measure: booking_count {
    type: count_distinct
    label: "Booking Count"
    description: "Refunded bookings, counted once each. A multi-ticket pair counts as one booking."
    sql: ${booking_id} ;;
  }

  measure: total_refunded_amount {
    type: sum
    label: "Total Refunded Amount"
    description: "Agency fare refund internal amount in the refund-line currency, master and slave combined, shown as a positive number. Only meaningful when grouped or pivoted by Refund Currency."
    sql: ${refunded_amount} ;;
    value_format_name: decimal_2
  }
}
