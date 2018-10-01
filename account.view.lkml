include: "fivetran_base.view"

explore: account_fb_adapter {
  view_name: account
  from: account_fb_adapter
  hidden: yes
}

view: account_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  sql_table_name: `facebook_ads_generated.account` ;;

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: account_status {
    hidden: yes
    type: string
    sql: "ACTIVE" ;;
  }

  dimension: status_active {
    hidden: yes
    type: yesno
    sql: ${account_status} = "ACTIVE" ;;
  }
  dimension: name {
    hidden: yes
    type: string
  }
}
