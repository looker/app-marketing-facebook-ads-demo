include: "account.view"
include: "fivetran_base.view"

explore: campaign_fb_adapter {
  view_name: campaign
  from: campaign_fb_adapter
  hidden: yes

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  sql_table_name: `facebook_ads_generated.campaign` ;;

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: account_id {
    hidden: yes
    type: number
    sql: CAST(${TABLE}.account_id AS STRING) ;;
  }

  dimension: effective_status {
    hidden: yes
    type: string
    sql: "ACTIVE" ;;
  }

  dimension: status_active {
    hidden: yes
    type: yesno
    sql: ${effective_status} = "ACTIVE" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}
