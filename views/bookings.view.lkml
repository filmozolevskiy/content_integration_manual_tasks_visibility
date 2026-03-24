view: bookings {

  sql_table_name: ota.bookings ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: pnr {
    hidden: yes
    type: string
    sql: ${TABLE}.pnr ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: process_status {
    hidden: yes
    type: string
    sql: ${TABLE}.process_status ;;
  }

  dimension: status_updated_by_admin {
    hidden: yes
    type: number
    sql: ${TABLE}.status_updated_by_admin ;;
  }

  dimension: site_id {
    hidden: yes
    type: number
    sql: ${TABLE}.site_id ;;
  }

  dimension: gds {
    type: string
    sql: ${TABLE}.gds ;;
  }

  dimension: gds_account_id {
    type: string
    sql: ${TABLE}.gds_account_id ;;
  }

  dimension: cancel_reason {
    hidden: yes
    type: string
    sql: ${TABLE}.cancel_reason ;;
  }

  dimension_group: booking_date {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.booking_date ;;
  }

  dimension_group: ticketing_deadline {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.ticketing_deadline ;;
  }

  dimension_group: departure_date {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.departure_date ;;
  }

  dimension: departure_airport_code {
    hidden: yes
    type: string
    sql: ${TABLE}.departure_airport_code ;;
  }

  dimension: destination_airport_code {
    hidden: yes
    type: string
    sql: ${TABLE}.destination_airport_code ;;
  }

  dimension: note {
    hidden: yes
    type: string
    sql: ${TABLE}.note ;;
  }

  dimension: ip_address {
    hidden: yes
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: user_agent {
    hidden: yes
    type: string
    sql: ${TABLE}.user_agent ;;
  }

  dimension: fare_type {
    hidden: yes
    type: string
    sql: ${TABLE}.fare_type ;;
  }

  dimension_group: ticketed_date {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.ticketed_date ;;
  }

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: rebooked {
    hidden: yes
    type: yesno
    sql: ${TABLE}.rebooked ;;
  }

  dimension: validating_carrier {
    type: string
    sql: ${TABLE}.validating_carrier ;;
  }

  dimension: id_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.id_hash ;;
  }

  dimension: primary_email_contact_info_id {
    hidden: yes
    type: number
    sql: ${TABLE}.primary_email_contact_info_id ;;
  }

  dimension: primary_phone_contact_info_id {
    hidden: yes
    type: number
    sql: ${TABLE}.primary_phone_contact_info_id ;;
  }

  dimension: contact_first_name {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_first_name ;;
  }

  dimension: contact_last_name {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_last_name ;;
  }

  dimension: contact_email {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_email ;;
  }

  dimension: contact_phone {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_phone ;;
  }

  dimension: preferred_language {
    hidden: yes
    type: string
    sql: ${TABLE}.preferred_language ;;
  }

  dimension: preferred_currency {
    hidden: yes
    type: string
    sql: ${TABLE}.preferred_currency ;;
  }

  dimension: is_test {
    type: yesno
    sql: ${TABLE}.is_test ;;
  }

  dimension: geoip_country_code {
    hidden: yes
    type: string
    sql: ${TABLE}.geoip_country_code ;;
  }

  dimension: geoip_region {
    hidden: yes
    type: string
    sql: ${TABLE}.geoip_region ;;
  }

  dimension: geoip_city {
    hidden: yes
    type: string
    sql: ${TABLE}.geoip_city ;;
  }

  dimension: original_pnr {
    hidden: yes
    type: string
    sql: ${TABLE}.original_pnr ;;
  }

  dimension: billing_info_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billing_info_id ;;
  }

  dimension: customer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: sp_booking_id {
    hidden: yes
    type: string
    sql: ${TABLE}.sp_booking_id ;;
  }

  dimension: insurance_eligible {
    hidden: yes
    type: yesno
    sql: ${TABLE}.insurance_eligible ;;
  }

  dimension: is_fraud {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_fraud ;;
  }

  dimension: processed {
    hidden: yes
    type: yesno
    sql: ${TABLE}.processed ;;
  }

  dimension: has_air {
    hidden: yes
    type: yesno
    sql: ${TABLE}.has_air ;;
  }

  dimension: has_hotel {
    hidden: yes
    type: yesno
    sql: ${TABLE}.has_hotel ;;
  }

  dimension: invoice_num {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_num ;;
  }

  dimension: is_urgent {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_urgent ;;
  }

  dimension: pre_auth_failed {
    hidden: yes
    type: yesno
    sql: ${TABLE}.pre_auth_failed ;;
  }

  dimension: create_commission_task {
    hidden: yes
    type: yesno
    sql: ${TABLE}.create_commission_task ;;
  }

  dimension: checkout_redirected {
    hidden: yes
    type: number
    sql: ${TABLE}.checkout_redirected ;;
  }

  dimension: default_merchant {
    hidden: yes
    type: string
    sql: ${TABLE}.default_merchant ;;
  }

  dimension: site_version {
    hidden: yes
    type: string
    sql: ${TABLE}.site_version ;;
  }

  dimension: checkout_status {
    hidden: yes
    type: string
    sql: ${TABLE}.checkout_status ;;
  }

  dimension: checkout_length {
    hidden: yes
    type: number
    sql: ${TABLE}.checkout_length ;;
  }

  dimension: debug_transaction_id {
    hidden: yes
    type: string
    sql: ${TABLE}.debug_transaction_id ;;
  }

  dimension: air_pnr {
    hidden: yes
    type: string
    sql: ${TABLE}.air_pnr ;;
  }

  dimension: universal_pnr {
    hidden: yes
    type: string
    sql: ${TABLE}.universal_pnr ;;
  }

  dimension: provider_code {
    hidden: yes
    type: string
    sql: ${TABLE}.provider_code ;;
  }

  dimension: softvoyage_pin_number {
    hidden: yes
    type: string
    sql: ${TABLE}.softvoyage_pin_number ;;
  }

  dimension: softvoyage_booking_number {
    hidden: yes
    type: string
    sql: ${TABLE}.softvoyage_booking_number ;;
  }

  dimension: tour_operator {
    hidden: yes
    type: string
    sql: ${TABLE}.tour_operator ;;
  }

  dimension: package_id {
    hidden: yes
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: api_user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.api_user_id ;;
  }

  dimension: valc_agent_id {
    hidden: yes
    type: number
    sql: ${TABLE}.valc_agent_id ;;
  }

  dimension: is_multiticket {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_multiticket ;;
  }

  dimension: multiticket_related_booking_id {
    hidden: yes
    type: number
    sql: ${TABLE}.multiticket_related_booking_id ;;
  }

  dimension: multiticket_relationship_type {
    hidden: yes
    type: string
    sql: ${TABLE}.multiticket_relationship_type ;;
  }

  dimension: multiticket_currency {
    hidden: yes
    type: string
    sql: ${TABLE}.multiticket_currency ;;
  }

  dimension: multiticket_exchange_rate {
    hidden: yes
    type: number
    sql: ${TABLE}.multiticket_exchange_rate ;;
  }

  dimension: fare_corporate_code {
    hidden: yes
    type: string
    sql: ${TABLE}.fare_corporate_code ;;
  }

  dimension: agent_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agent_id ;;
  }

  dimension: out_of_sync {
    hidden: yes
    type: yesno
    sql: ${TABLE}.out_of_sync ;;
  }

  dimension_group: sync_time {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sync_time ;;
  }

  dimension: send_sync_email {
    hidden: yes
    type: yesno
    sql: ${TABLE}.send_sync_email ;;
  }

  dimension_group: next_sc_check {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.next_sc_check ;;
  }

  dimension: last_segment_id {
    hidden: yes
    type: number
    sql: ${TABLE}.last_segment_id ;;
  }

  dimension: tour_code {
    hidden: yes
    type: string
    sql: ${TABLE}.tour_code ;;
  }

  dimension: agencia_agent_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agencia_agent_id ;;
  }

  dimension: agencia_agency_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agencia_agency_id ;;
  }

  dimension: on_hold {
    hidden: yes
    type: yesno
    sql: ${TABLE}.on_hold ;;
  }

  dimension_group: hold_end_time {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.hold_end_time ;;
  }

  dimension: reward_points {
    hidden: yes
    type: number
    sql: ${TABLE}.reward_points ;;
  }

  dimension: is_webfare {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_webfare ;;
  }

  dimension: ticket_designator {
    hidden: yes
    type: string
    sql: ${TABLE}.ticket_designator ;;
  }

  dimension: exchange_rate {
    hidden: yes
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension: farelogix_source {
    hidden: yes
    type: string
    sql: ${TABLE}.farelogix_source ;;
  }

  dimension: is_airline_controlled {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_airline_controlled ;;
  }

  dimension_group: return_date {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.return_date ;;
  }

  dimension: checkout_fare_total {
    hidden: yes
    type: number
    sql: ${TABLE}.checkout_fare_total ;;
  }

  dimension: display_currency {
    hidden: yes
    type: string
    sql: ${TABLE}.display_currency ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
