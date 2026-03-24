view: booking_log {

  sql_table_name: ota.booking_log ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: booking_id {
    type: number
    sql: ${TABLE}.booking_id ;;
  }

  dimension_group: date_added {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_added ;;
  }

  dimension: employee_id {
    type: number
    sql: ${TABLE}.employee_id ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: is_escalating_manual_ticket {
    label: "Escalating to Manual Ticket"
    description: "Message contains Escalating to Manual Ticket."
    type: yesno
    sql: ${TABLE}.message LIKE '%%Escalating to Manual Ticket.%%' ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
