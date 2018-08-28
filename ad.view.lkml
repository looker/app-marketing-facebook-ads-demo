include: "adset.view"
include: "fivetran_base.view"

explore: ad_fb_adapter {
  view_name: ad
  from: ad_fb_adapter
  hidden: yes

  join: adset {
    from: adset_fb_adapter
    type: left_outer
    sql_on: ${ad.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: ad_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  sql_table_name: `facebook_ads_generated.ad` ;;

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: adset_id {
    hidden: yes
    type: number
    sql: ${TABLE}.adset_id ;;
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
  }

  dimension: objective {
    type: string
  }
}
