SELECT 
client,
platform,
domain,
domain_canonical,
url,
canonical_url_length,
longest_url_length,
url_stripped,
canonical_url,
canonical_url_stripped,
canonical_status,
url_protocol,
canonical_url_protocol,
protocol_match,
protocol_count,
path_count,
first_path,
last_path,
query_string,
filename,
last_subfolder,
last_subfolder_canonical,
first_subfolder,
second_subfolder,
urls_to_canonical,
crawl_datetime,
found_at_sitemap,
http_status_code,
level,
schema_type,
header_content_type,
word_count, 
med_word_count,
page_title,
page_title_length,
description,
description_length,
indexable,
robots_noindex,
is_self_canonical,
backlink_count,
backlink_domain_count,
redirected_to_url,
found_at_url,
rel_next_url,
rel_prev_url,
links_in_count,
links_out_count,
external_links_count,
internal_links_count,
h1_tag,
h2_tag,
redirect_chain,
redirected_to_status_code,
is_redirect_loop,
duplicate_page,
duplicate_page_count,
duplicate_body,
duplicate_body_count,
class_sitemap,
class_schema,
class_google_maps,
flag_blog_path,
flag_blog_h1,
flag_high_word_count,
flag_thin_page,
flag_reviews,
flag_select_size,
flag_add_to_cart,
flag_prices,
flag_above_avg_prices,
flag_form_submit,
flag_learn_more,
flag_info_path,
flag_paginated,
product_score,
category_score,
article_score,
case 
	when url = domain then 'homepage'
	when url like '%404%' then '404'
	when class_schema is not null then class_schema
	when class_google_maps is not null then class_google_maps
	when class_sitemap in ('article', 'product') then class_sitemap
	when class_sitemap = 'category' and flag_prices = 0 then 'blog_category'
	when class_sitemap = 'category' and flag_prices = 1 then 'product_category'
	when ( flag_info_path = 1 and flag_blog_path = 0 and flag_blog_h1 = 0 ) then 'info'
	when product_score >=2 then 'product'
	when flag_prices = 1 then 'product_category'
	when flag_paginated = 1 then 'blog_category'
	when flag_form_submit = 1 then 'lead_generation'
	when flag_learn_more = 1 then 'blog_category'
	when class_sitemap is not null then class_sitemap
	when article_score >= 1 then 'article'
	else 'unclassified' end as classification
FROM 
(
	SELECT 
	client,
	platform,
	domain,
	domain_canonical,
	url,
	canonical_url_length,
	first_value(canonical_url_length) over (partition by url_stripped order by canonical_url_length desc) longest_url_length,
	url_stripped,
	canonical_url,
	canonical_url_stripped,
	canonical_status,
	url_protocol,
	canonical_url_protocol,
	protocol_match,
	protocol_count,
	path_count,
	first_path,
	last_path,
	query_string,
	filename,
	last_subfolder,
	last_subfolder_canonical,
	first_subfolder,
	second_subfolder,
	urls_to_canonical,
	crawl_datetime,
	found_at_sitemap,
	http_status_code,
	level,
	schema_type,
	header_content_type,
	word_count, 
	med_word_count,
	page_title,
	page_title_length,
	description,
	description_length,
	indexable,
	robots_noindex,
	is_self_canonical,
	backlink_count,
	backlink_domain_count,
	redirected_to_url,
	found_at_url,
	rel_next_url,
	rel_prev_url,
  	links_in_count,
  	links_out_count,
  	external_links_count,
  	internal_links_count,	
	h1_tag,
	h2_tag,
	redirect_chain,
	redirected_to_status_code,
	is_redirect_loop,
	duplicate_page,
	duplicate_page_count,
	duplicate_body,
	duplicate_body_count,
	class_sitemap,
	class_schema,
	class_google_maps,
	flag_blog_path,
	flag_blog_h1,
	flag_high_word_count,
	flag_thin_page,
	flag_reviews,
	flag_select_size,
	flag_add_to_cart,
	flag_prices,
	flag_above_avg_prices,
	flag_learn_more,
	flag_info_path,
	flag_form_submit,
	flag_paginated,
	(flag_reviews + flag_select_size + flag_add_to_cart + flag_prices) as product_score,
	(flag_reviews + flag_select_size + flag_add_to_cart + flag_above_avg_prices) as category_score,
	(flag_blog_path + flag_blog_h1 + flag_high_word_count) as article_score
	FROM {{ref('deepcrawl_url_proc')}}
) 
where ( canonical_url_length = longest_url_length or longest_url_length is null )
