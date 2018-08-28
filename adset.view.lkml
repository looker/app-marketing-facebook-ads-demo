include: "campaign.view"
include: "fivetran_base.view"

explore: adset_fb_adapter {
  view_name: adset
  from: adset_fb_adapter
  hidden: yes

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: adset_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  sql_table_name: `facebook_ads_generated.adset` ;;

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: number
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
}
