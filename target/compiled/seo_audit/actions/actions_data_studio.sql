SELECT
date,
client,
url,
sitemap,
domain,
canonical_url,
canonical_status,
page_type,
page_objective,
admin_action,
admin_action_reason,
case when admin_action in ('', 'missing from crawl') then content_action else '' end as content_action,
case when admin_action in ('', 'missing from crawl') then link_action else '' end as link_action,
case when admin_action in ('', 'missing from crawl') then meta_rewrite_action else '' end as meta_rewrite_action,
case when admin_action in ('', 'missing from crawl') then pagination_action else '' end as pagination_action,
first_subfolder,
first_subfolder_http_status,
second_subfolder,
second_subfolder_http_status,
last_subfolder,
last_subfolder_http_status,
http_status_code,
level,
schema_type,
header_content_type,
word_count, 
page_title,
title_contains_top_keyword,
page_title_length,
description,
description_contains_top_keyword,
description_length,
robots_noindex,
redirected_to_url,
links_in_count,
links_out_count,
h1_tag,
h2_tag,
redirect_chain,
redirected_to_status_code,
is_redirect_loop,
duplicate_page,
duplicate_page_count,
duplicate_body,
duplicate_body_count,
sessions_30d,
revenue_30d,
transactions_30d,
pageviews_30d,
#lead_conversion_rate_30d,
transaction_conversion_rate_30d,
#med_lead_conversion_rate_30d,
med_transaction_conversion_rate_30d,
sessions_mom,
revenue_mom,
transactions_mom,
pageviews_mom,
sessions_mom_pct,
revenue_mom_pct,
transactions_mom_pct,
sessions_yoy,
revenue_yoy,
transactions_yoy,
pageviews_yoy,
sessions_yoy_pct,
revenue_yoy_pct,
transactions_yoy_pct,
gaining_traffic_mom,
gaining_traffic_yoy,
ref_domain_count,
med_ref_domain_count,
avg_trust_flow,
avg_citation_flow,
gsc_keyword_count_90d,
gsc_impressions_90d,
gsc_clicks_90d,	
gsc_ctr_90d,
gsc_top_keyword_90d,
gsc_top_url_for_keyword_90d,
gsc_top_canonical_url_for_keyword_90d,
gsc_top_keyword_impressions_90d, 
gsc_top_keyword_clicks_90d, 
gsc_top_keyword_ctr_90d,
semrush_keyword_count,
semrush_total_cpc,
semrush_total_search_volume,
semrush_top_keyword_vol,
semrush_top_keyword_vol_vol, 
semrush_top_keyword_vol_cpc, 
semrush_top_keyword_cpc,
semrush_top_keyword_cpc_vol, 
semrush_top_keyword_cpc_cpc	
FROM `curious-domain-121318`.`seo_audit`.`actions_hierarchy`