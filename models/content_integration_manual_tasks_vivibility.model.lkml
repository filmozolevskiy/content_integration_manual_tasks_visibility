connection: "ota"

include: "/views/**/*.view.lkml"

datagroup: content_integration_manual_tasks_vivibility_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: content_integration_manual_tasks_vivibility_default_datagroup


explore: booking_log {
  sql_always_where:
    ${booking_log.date_added_raw} >= NOW() - INTERVAL 6 MONTH
    AND ${booking_log.message} LIKE '%%Escalating to Manual%%' ;;
}
