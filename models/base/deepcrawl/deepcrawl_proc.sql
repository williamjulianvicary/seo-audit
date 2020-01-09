-- SELECT 
-- domain,
-- site,
-- url,
-- crawl_datetime,
-- crawl_date,
-- crawl_month,
-- crawl_report_month,
-- latest_crawl_datetime,
-- query_string_url_first_param,
-- query_string_url,
-- query_string_canonical_url,  
-- max(domain_canonical) domain_canonical,
-- max(url_stripped) url_stripped,
-- max(canonical_url) canonical_url,
-- max(urls_to_canonical) urls_to_canonical,
-- max(found_at_sitemap) found_at_sitemap,
-- max(http_status_code) http_status_code,
-- max(url_protocol) url_protocol,
-- max(canonical_url_protocol) canonical_url_protocol,
-- max(level) level,
-- max(schema_type) schema_type,
-- max(header_content_type) header_content_type,
-- max(word_count) word_count, 
-- max(page_title) page_title,
-- max(page_title_length) page_title_length,
-- max(description) description,
-- max(description_length) description_length,
-- max(indexable) indexable,
-- max(robots_noindex) robots_noindex,
-- max(meta_noindex) meta_noindex,
-- max(is_self_canonical) is_self_canonical,
-- max(backlink_count) backlink_count,
-- max(backlink_domain_count) backlink_domain_count,
-- max(redirected_to_url) redirected_to_url,
-- max(self_redirect) self_redirect,
-- max(found_at_url) found_at_url,
-- max(rel_next_url) rel_next_url,
-- max(rel_prev_url) rel_prev_url,
-- max(links_in_count) links_in_count,
-- max(links_out_count) links_out_count,
-- max(external_links_count) external_links_count,
-- max(internal_links_count) internal_links_count,
-- max(h1_tag) h1_tag,
-- max(h2_tag) h2_tag,
-- max(redirect_chain) redirect_chain,
-- max(redirected_to_status_code) redirected_to_status_code,
-- max(is_redirect_loop) is_redirect_loop,
-- max(duplicate_page) duplicate_page,
-- max(duplicate_page_count) duplicate_page_count,
-- max(duplicate_body) duplicate_body,
-- max(duplicate_body_count) duplicate_body_count,
-- max(qt_dec_price) qt_dec_price,
-- max(qt_cur_price) qt_cur_price,
-- max(qt_add_to_cart) qt_add_to_cart,
-- max(qt_google_maps) qt_google_maps,
-- max(qt_learn_more) qt_learn_more,
-- max(qt_reviews) qt_reviews,
-- max(qt_size) qt_size,
-- max(qt_form_submit) qt_form_submit,
-- max(qt_infinite_scroll) qt_infinite_scroll,
-- max(decimal_price) decimal_price,
-- max(currency_price) currency_price,
-- max(add_to_cart) add_to_cart,
-- max(learn_more) learn_more,
-- max(review) review,
-- max(size) size,
-- max(paginated_page) paginated_page

SELECT *
FROM (

  SELECT
  crawl_id,
  first_value(crawl_id) over w2 as latest_crawl_id,
  count(distinct(url)) OVER (PARTITION by canonical_url) urls_to_canonical,
  first_value(crawl_datetime) OVER w1 as latest_crawl_datetime,    
  first_value(query_string_url) over w1 as latest_query_string_url,
  domain,
  site,
  url,
  url_stripped,
  non_html_url,
  domain_canonical,
  canonical_url,
  canonical_url_stripped,
  query_string_url_first_param,
  query_string_url,
  query_string_canonical_url,  
  url_protocol,
  canonical_url_protocol,
  is_canonicalized,
  crawl_datetime,
  crawl_date,
  crawl_month,
  crawl_report_month,
  found_at_sitemap,
  http_status_code,
  level,
  schema_type,
  header_content_type,
  word_count, 
  page_title,
  page_title_length,
  description,
  description_length,
  indexable,
  robots_noindex,
  meta_noindex,
  is_self_canonical,
  backlink_count,
  backlink_domain_count,
  redirected_to_url,
  self_redirect,
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
  qt_dec_price,
  qt_cur_price,
  qt_add_to_cart,
  qt_google_maps,
  qt_learn_more,
  qt_reviews,
  qt_size,
  qt_form_submit,
  qt_infinite_scroll,
  decimal_price,
  currency_price,
  add_to_cart,
  learn_more,
  review,
  size,
  paginated_page
  FROM 
  (
    SELECT 
    crawl_id,
    a.domain,
    b.site,
    CASE WHEN url = canonical_url THEN url
      WHEN url_stripped = canonical_url_stripped AND query_string_url_first_param = query_string_canonical_url THEN canonical_url
      -- WHEN query_string_url_first_param is not null THEN null
      -- WHEN http_status_code = 404 THEN url
      ELSE url_stripped
      END as url,      
    url_stripped,
    non_html_url,
    domain_canonical,
    canonical_url,
    canonical_url_stripped,
    query_string_url_first_param,
    query_string_url,
    query_string_canonical_url,  
    url_protocol,
    canonical_url_protocol,
    is_canonicalized,
    crawl_datetime,
    crawl_date,
    crawl_month,
    CASE WHEN extract(DAY from crawl_date) >= 15 THEN crawl_month ELSE date_sub(crawl_month, INTERVAL 1 MONTH) END as crawl_report_month,
    found_at_sitemap,
    http_status_code,
    level,
    schema_type,
    header_content_type,
    word_count, 
    page_title,
    page_title_length,
    description,
    description_length,
    indexable,
    robots_noindex,
    meta_noindex,
    is_self_canonical,
    backlink_count,
    backlink_domain_count,
    redirected_to_url,
    self_redirect,
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
    qt_dec_price,
    qt_cur_price,
    qt_add_to_cart,
    qt_google_maps,
    qt_learn_more,
    qt_reviews,
    qt_size,
    qt_form_submit,
    qt_infinite_scroll,
    decimal_price,
    currency_price,
    add_to_cart,
    learn_more,
    review,
    size,
    paginated_page
    FROM
    ( 

        SELECT 
        crawl_id,
        lower(replace(replace(replace(url,'www.',''),'http://',''),'https://','')) as url,
        lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as url_stripped,
        -- CASE WHEN regexp_contains(url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(regexp_replace(replace(replace(replace(url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   END as url_stripped,
        regexp_contains(url, '.img$|.png$|.jpg$|.css$.|js$|.pdf$') as non_html_url,
        regexp_extract(url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain,
        regexp_extract(canonical_url,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') as domain_canonical,
        lower(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://','')) canonical_url,
        lower(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$','')) as canonical_url_stripped,
        -- CASE WHEN regexp_contains(canonical_url, r'^.*\/([^\/]+?\.[^\/]+)$') 
        --   THEN lower(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''))
        --   ELSE lower(trim(regexp_replace(replace(replace(replace(canonical_url,'www.',''),'http://',''),'https://',''),r'\?.*$',''),'/'))
        --   END as canonical_url_stripped,      
        ifnull(split(split(url, '?')[SAFE_ORDINAL(2)],'&')[SAFE_ORDINAL(1)], '') query_string_url_first_param,
        ifnull(split(url, '?')[SAFE_ORDINAL(2)], '') as query_string_url,
        ifnull(split(canonical_url, '?')[SAFE_ORDINAL(2)], '') as query_string_canonical_url,
        case when url like 'https%' then 'https' 
          when url like 'http%' then 'http'
          else 'none' end as url_protocol,
        case when canonical_url like 'https%' then 'https' 
          when canonical_url like 'http%' then 'http'
          else 'none' end as canonical_url_protocol, 
        case 
          when canonical_url is not null then 1
          else 0 end as is_canonicalized,
        crawl_datetime,  
        cast(crawl_datetime as date) crawl_date,
        DATE_TRUNC(date( crawl_datetime ), month) crawl_month,
        found_at_sitemap,
        http_status_code,
        level,
        lower(schema_type) schema_type,
        header_content_type,
        word_count, 
        page_title,
        page_title_length,
        description,
        description_length,
        indexable,
        robots_noindex,
        meta_noindex,
        is_self_canonical,
        cast(backlink_count as int64) backlink_count,
        cast(backlink_domain_count as int64) backlink_domain_count,
        redirected_to_url,
        CASE WHEN regexp_extract(trim(redirected_to_url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
          OR regexp_extract(trim(url, '/'),r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)') = regexp_extract(redirected_to_url ,r'^(?:https?:\/\/)?(?:www\.)?([^\/]+)')
          THEN 1 ELSE 0 END as self_redirect,
        found_at_url,
        rel_next_url,
        rel_prev_url,
        links_in_count,
        links_out_count,
        external_links_count,
        internal_links_count,
        lower(replace(replace(replace(h1_tag, "[\"",""),"\"]",""),'"','')) h1_tag,
        lower(replace(replace(replace(h2_tag, "[\"",""),"\"]",""),'"','')) h2_tag,
        redirect_chain,
        redirected_to_status_code,
        is_redirect_loop,
        duplicate_page,
        duplicate_page_count,
        duplicate_body,
        duplicate_body_count,
        form_submit,
        infinite_scroll,
        (LENGTH(decimal_price) - LENGTH(REGEXP_REPLACE(decimal_price, '"', '')))/2 as qt_dec_price,
        (LENGTH(currency_price) - LENGTH(REGEXP_REPLACE(currency_price, '"', '')))/2 as qt_cur_price,
        (LENGTH(Add_to_cart) - LENGTH(REGEXP_REPLACE(Add_to_cart, '"', '')))/2 as qt_add_to_cart,
        (LENGTH(Google_Maps) - LENGTH(REGEXP_REPLACE(Google_Maps, '"', '')))/2 as qt_google_maps,
        (LENGTH(Learn_more) - LENGTH(REGEXP_REPLACE(Learn_more, '"', '')))/2 as qt_learn_more,
        (LENGTH(Review) - LENGTH(REGEXP_REPLACE(Review, '"', '')))/2 as qt_reviews,
        (LENGTH(Size) - LENGTH(REGEXP_REPLACE(Size, '"', '')))/2 as qt_size,
        (LENGTH(form_submit) - LENGTH(REGEXP_REPLACE(form_submit, '"', '')))/2 as qt_form_submit,
        (LENGTH(infinite_scroll) - LENGTH(REGEXP_REPLACE(infinite_scroll, '"', '')))/2 as qt_infinite_scroll,
        decimal_price,
        currency_price,
        google_maps,
        add_to_cart,
        learn_more,
        review,
        size,
        paginated_page      
        FROM  
        `{{ target.project }}.{{ target.schema }}.deepcrawl` 
        WHERE url not like '%target=_blank%'
        AND ( url = primary_url OR primary_url is null )
        AND http_status_code not in (401, 403, 503)
      ) a
    LEFT JOIN {{ ref('domains_proc') }} b
    ON (
      a.domain = b.domain
      )
     )
    WHERE self_redirect = 0 
    AND non_html_url = false
    WINDOW w1 as (PARTITION BY domain, crawl_month, url ORDER BY found_at_sitemap desc, is_canonicalized desc, crawl_datetime desc ),
    w2 as (PARTITION BY domain, crawl_report_month ORDER BY crawl_id desc )
)
WHERE latest_crawl_datetime = crawl_datetime
AND latest_crawl_id = crawl_id
AND latest_query_string_url = query_string_url
GROUP BY   crawl_id,
  latest_crawl_id,
  urls_to_canonical,
  latest_crawl_datetime,    
  latest_query_string_url,
  domain,
  site,
  url,
  url_stripped,
  non_html_url,
  domain_canonical,
  canonical_url,
  canonical_url_stripped,
  query_string_url_first_param,
  query_string_url,
  query_string_canonical_url,  
  url_protocol,
  canonical_url_protocol,
  is_canonicalized,
  crawl_datetime,
  crawl_date,
  crawl_month,
  crawl_report_month,
  found_at_sitemap,
  http_status_code,
  level,
  schema_type,
  header_content_type,
  word_count, 
  page_title,
  page_title_length,
  description,
  description_length,
  indexable,
  robots_noindex,
  meta_noindex,
  is_self_canonical,
  backlink_count,
  backlink_domain_count,
  redirected_to_url,
  self_redirect,
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
  qt_dec_price,
  qt_cur_price,
  qt_add_to_cart,
  qt_google_maps,
  qt_learn_more,
  qt_reviews,
  qt_size,
  qt_form_submit,
  qt_infinite_scroll,
  decimal_price,
  currency_price,
  add_to_cart,
  learn_more,
  review,
  size,
  paginated_page