# Why (2026-10-02): derived table on purpose. The metric needs two
# per-booking aggregations (first refund task, summed refund tax) before
# they are joined; joining the raw tables would repeat the tax once per
# task. Requested to back a tile on dashboard 1752 after Looker refused
# to save the same query from SQL Runner.
#
# One row per refunded booking. A booking counts once, on the day of its
# first refund task. Tax is in USD: kept as-is when the statement item is
# in USD, multiplied by bookings.exchange_rate when the booking is in USD
# (that rate converts statement currency into booking currency). Items
# where neither is USD are left out of the total and counted in
# unconverted_items.
view: wenrix_refunds {
  derived_table: {
    sql:
      SELECT
        t.booking_id,
        t.refund_processed_at,
        -r.refunded_tax_usd AS refunded_tax_usd,
        r.unconverted_items
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
        SELECT
          bsi.booking_id,
          SUM(CASE
                WHEN bsi.currency = 'USD' THEN bsi.tax
                WHEN b.currency = 'USD' THEN bsi.tax * b.exchange_rate
              END) AS refunded_tax_usd,
          SUM(bsi.currency <> 'USD' AND b.currency <> 'USD') AS unconverted_items
        FROM booking_statement_items bsi
        JOIN bookings b ON b.id = bsi.booking_id
        WHERE bsi.type = 'fare'
          AND bsi.transaction_type = 'refund'
          AND bsi.payment_processor = 'agency'
          AND bsi.status != 'deleted'
          AND bsi.create_date > '2026-09-23 12:22:40'
        GROUP BY bsi.booking_id
      ) r ON r.booking_id = t.booking_id ;;
  }

  dimension: booking_id {
    primary_key: yes
    type: number
    description: "Booking with at least one refund task (type 109, not a correction)."
    sql: ${TABLE}.booking_id ;;
  }

  dimension_group: refund_processed {
    type: time
    timeframes: [raw, date, week, month]
    description: "Time of the booking's first refund task."
    sql: ${TABLE}.refund_processed_at ;;
  }

  dimension: refunded_tax_usd {
    hidden: yes
    type: number
    sql: ${TABLE}.refunded_tax_usd ;;
  }

  dimension: unconverted_item_count {
    hidden: yes
    type: number
    sql: ${TABLE}.unconverted_items ;;
  }

  measure: booking_count {
    type: count_distinct
    label: "Booking Count"
    description: "Refunded bookings, counted once each."
    sql: ${booking_id} ;;
  }

  measure: total_refunded_tax_usd {
    type: sum
    label: "Total Refunded Tax USD"
    description: "Agency fare refund tax in USD, shown as a positive number."
    sql: ${refunded_tax_usd} ;;
    value_format_name: usd
  }

  measure: unconverted_items {
    type: sum
    label: "Unconverted Items"
    description: "Refund lines left out of the USD total because neither the line nor the booking is in USD."
    sql: ${unconverted_item_count} ;;
  }
}
