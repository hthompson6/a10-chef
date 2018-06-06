resource_name :a10_slb_template_http

property :a10_name, String, name_property: true
property :keep_client_alive, [true, false]
property :compression_auto_disable_on_high_cpu, Integer
property :req_hdr_wait_time, [true, false]
property :compression_exclude_uri, Array
property :compression_enable, [true, false]
property :compression_keep_accept_encoding, [true, false]
property :failover_url, String
property :redirect_rewrite, Hash
property :request_header_erase_list, Array
property :rd_port, Integer
property :host_switching, Array
property :url_hash_last, Integer
property :client_ip_hdr_replace, [true, false]
property :use_server_status, [true, false]
property :req_hdr_wait_time_val, Integer
property :response_header_insert_list, Array
property :persist_on_401, [true, false]
property :redirect, [true, false]
property :insert_client_port, [true, false]
property :retry_on_5xx_per_req_val, Integer
property :url_hash_offset, Integer
property :rd_simple_loc, String
property :log_retry, [true, false]
property :non_http_bypass, [true, false]
property :retry_on_5xx_per_req, [true, false]
property :insert_client_ip, [true, false]
property :template, Hash
property :url_switching, Array
property :insert_client_port_header_name, String
property :strict_transaction_switch, [true, false]
property :response_content_replace_list, Array
property :http_100_cont_wait_for_req_complete, [true, false]
property :request_header_insert_list, Array
property :compression_minimum_content_length, Integer
property :compression_level, Integer
property :request_line_case_insensitive, [true, false]
property :url_hash_persist, [true, false]
property :response_header_erase_list, Array
property :uuid, String
property :bypass_sg, String
property :retry_on_5xx_val, Integer
property :url_hash_first, Integer
property :compression_keep_accept_encoding_enable, [true, false]
property :user_tag, String
property :compression_content_type, Array
property :client_port_hdr_replace, [true, false]
property :insert_client_ip_header_name, String
property :rd_secure, [true, false]
property :retry_on_5xx, [true, false]
property :cookie_format, ['rfc6265']
property :term_11client_hdr_conn_close, [true, false]
property :compression_exclude_content_type, Array
property :rd_resp_code, ['301','302','303','307']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/http/"
    get_url = "/axapi/v3/slb/template/http/%<name>s"
    keep_client_alive = new_resource.keep_client_alive
    compression_auto_disable_on_high_cpu = new_resource.compression_auto_disable_on_high_cpu
    req_hdr_wait_time = new_resource.req_hdr_wait_time
    compression_exclude_uri = new_resource.compression_exclude_uri
    compression_enable = new_resource.compression_enable
    compression_keep_accept_encoding = new_resource.compression_keep_accept_encoding
    failover_url = new_resource.failover_url
    redirect_rewrite = new_resource.redirect_rewrite
    request_header_erase_list = new_resource.request_header_erase_list
    rd_port = new_resource.rd_port
    host_switching = new_resource.host_switching
    url_hash_last = new_resource.url_hash_last
    client_ip_hdr_replace = new_resource.client_ip_hdr_replace
    use_server_status = new_resource.use_server_status
    req_hdr_wait_time_val = new_resource.req_hdr_wait_time_val
    response_header_insert_list = new_resource.response_header_insert_list
    persist_on_401 = new_resource.persist_on_401
    redirect = new_resource.redirect
    insert_client_port = new_resource.insert_client_port
    retry_on_5xx_per_req_val = new_resource.retry_on_5xx_per_req_val
    url_hash_offset = new_resource.url_hash_offset
    rd_simple_loc = new_resource.rd_simple_loc
    log_retry = new_resource.log_retry
    non_http_bypass = new_resource.non_http_bypass
    retry_on_5xx_per_req = new_resource.retry_on_5xx_per_req
    insert_client_ip = new_resource.insert_client_ip
    template = new_resource.template
    url_switching = new_resource.url_switching
    insert_client_port_header_name = new_resource.insert_client_port_header_name
    strict_transaction_switch = new_resource.strict_transaction_switch
    response_content_replace_list = new_resource.response_content_replace_list
    http_100_cont_wait_for_req_complete = new_resource.http_100_cont_wait_for_req_complete
    request_header_insert_list = new_resource.request_header_insert_list
    compression_minimum_content_length = new_resource.compression_minimum_content_length
    compression_level = new_resource.compression_level
    request_line_case_insensitive = new_resource.request_line_case_insensitive
    url_hash_persist = new_resource.url_hash_persist
    response_header_erase_list = new_resource.response_header_erase_list
    uuid = new_resource.uuid
    bypass_sg = new_resource.bypass_sg
    a10_name = new_resource.a10_name
    retry_on_5xx_val = new_resource.retry_on_5xx_val
    url_hash_first = new_resource.url_hash_first
    compression_keep_accept_encoding_enable = new_resource.compression_keep_accept_encoding_enable
    user_tag = new_resource.user_tag
    compression_content_type = new_resource.compression_content_type
    client_port_hdr_replace = new_resource.client_port_hdr_replace
    insert_client_ip_header_name = new_resource.insert_client_ip_header_name
    rd_secure = new_resource.rd_secure
    retry_on_5xx = new_resource.retry_on_5xx
    cookie_format = new_resource.cookie_format
    term_11client_hdr_conn_close = new_resource.term_11client_hdr_conn_close
    compression_exclude_content_type = new_resource.compression_exclude_content_type
    rd_resp_code = new_resource.rd_resp_code

    params = { "http": {"keep-client-alive": keep_client_alive,
        "compression-auto-disable-on-high-cpu": compression_auto_disable_on_high_cpu,
        "req-hdr-wait-time": req_hdr_wait_time,
        "compression-exclude-uri": compression_exclude_uri,
        "compression-enable": compression_enable,
        "compression-keep-accept-encoding": compression_keep_accept_encoding,
        "failover-url": failover_url,
        "redirect-rewrite": redirect_rewrite,
        "request-header-erase-list": request_header_erase_list,
        "rd-port": rd_port,
        "host-switching": host_switching,
        "url-hash-last": url_hash_last,
        "client-ip-hdr-replace": client_ip_hdr_replace,
        "use-server-status": use_server_status,
        "req-hdr-wait-time-val": req_hdr_wait_time_val,
        "response-header-insert-list": response_header_insert_list,
        "persist-on-401": persist_on_401,
        "redirect": redirect,
        "insert-client-port": insert_client_port,
        "retry-on-5xx-per-req-val": retry_on_5xx_per_req_val,
        "url-hash-offset": url_hash_offset,
        "rd-simple-loc": rd_simple_loc,
        "log-retry": log_retry,
        "non-http-bypass": non_http_bypass,
        "retry-on-5xx-per-req": retry_on_5xx_per_req,
        "insert-client-ip": insert_client_ip,
        "template": template,
        "url-switching": url_switching,
        "insert-client-port-header-name": insert_client_port_header_name,
        "strict-transaction-switch": strict_transaction_switch,
        "response-content-replace-list": response_content_replace_list,
        "100-cont-wait-for-req-complete": http_100_cont_wait_for_req_complete,
        "request-header-insert-list": request_header_insert_list,
        "compression-minimum-content-length": compression_minimum_content_length,
        "compression-level": compression_level,
        "request-line-case-insensitive": request_line_case_insensitive,
        "url-hash-persist": url_hash_persist,
        "response-header-erase-list": response_header_erase_list,
        "uuid": uuid,
        "bypass-sg": bypass_sg,
        "name": a10_name,
        "retry-on-5xx-val": retry_on_5xx_val,
        "url-hash-first": url_hash_first,
        "compression-keep-accept-encoding-enable": compression_keep_accept_encoding_enable,
        "user-tag": user_tag,
        "compression-content-type": compression_content_type,
        "client-port-hdr-replace": client_port_hdr_replace,
        "insert-client-ip-header-name": insert_client_ip_header_name,
        "rd-secure": rd_secure,
        "retry-on-5xx": retry_on_5xx,
        "cookie-format": cookie_format,
        "term-11client-hdr-conn-close": term_11client_hdr_conn_close,
        "compression-exclude-content-type": compression_exclude_content_type,
        "rd-resp-code": rd_resp_code,} }

    params[:"http"].each do |k, v|
        if not v 
            params[:"http"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/http/%<name>s"
    keep_client_alive = new_resource.keep_client_alive
    compression_auto_disable_on_high_cpu = new_resource.compression_auto_disable_on_high_cpu
    req_hdr_wait_time = new_resource.req_hdr_wait_time
    compression_exclude_uri = new_resource.compression_exclude_uri
    compression_enable = new_resource.compression_enable
    compression_keep_accept_encoding = new_resource.compression_keep_accept_encoding
    failover_url = new_resource.failover_url
    redirect_rewrite = new_resource.redirect_rewrite
    request_header_erase_list = new_resource.request_header_erase_list
    rd_port = new_resource.rd_port
    host_switching = new_resource.host_switching
    url_hash_last = new_resource.url_hash_last
    client_ip_hdr_replace = new_resource.client_ip_hdr_replace
    use_server_status = new_resource.use_server_status
    req_hdr_wait_time_val = new_resource.req_hdr_wait_time_val
    response_header_insert_list = new_resource.response_header_insert_list
    persist_on_401 = new_resource.persist_on_401
    redirect = new_resource.redirect
    insert_client_port = new_resource.insert_client_port
    retry_on_5xx_per_req_val = new_resource.retry_on_5xx_per_req_val
    url_hash_offset = new_resource.url_hash_offset
    rd_simple_loc = new_resource.rd_simple_loc
    log_retry = new_resource.log_retry
    non_http_bypass = new_resource.non_http_bypass
    retry_on_5xx_per_req = new_resource.retry_on_5xx_per_req
    insert_client_ip = new_resource.insert_client_ip
    template = new_resource.template
    url_switching = new_resource.url_switching
    insert_client_port_header_name = new_resource.insert_client_port_header_name
    strict_transaction_switch = new_resource.strict_transaction_switch
    response_content_replace_list = new_resource.response_content_replace_list
    http_100_cont_wait_for_req_complete = new_resource.http_100_cont_wait_for_req_complete
    request_header_insert_list = new_resource.request_header_insert_list
    compression_minimum_content_length = new_resource.compression_minimum_content_length
    compression_level = new_resource.compression_level
    request_line_case_insensitive = new_resource.request_line_case_insensitive
    url_hash_persist = new_resource.url_hash_persist
    response_header_erase_list = new_resource.response_header_erase_list
    uuid = new_resource.uuid
    bypass_sg = new_resource.bypass_sg
    a10_name = new_resource.a10_name
    retry_on_5xx_val = new_resource.retry_on_5xx_val
    url_hash_first = new_resource.url_hash_first
    compression_keep_accept_encoding_enable = new_resource.compression_keep_accept_encoding_enable
    user_tag = new_resource.user_tag
    compression_content_type = new_resource.compression_content_type
    client_port_hdr_replace = new_resource.client_port_hdr_replace
    insert_client_ip_header_name = new_resource.insert_client_ip_header_name
    rd_secure = new_resource.rd_secure
    retry_on_5xx = new_resource.retry_on_5xx
    cookie_format = new_resource.cookie_format
    term_11client_hdr_conn_close = new_resource.term_11client_hdr_conn_close
    compression_exclude_content_type = new_resource.compression_exclude_content_type
    rd_resp_code = new_resource.rd_resp_code

    params = { "http": {"keep-client-alive": keep_client_alive,
        "compression-auto-disable-on-high-cpu": compression_auto_disable_on_high_cpu,
        "req-hdr-wait-time": req_hdr_wait_time,
        "compression-exclude-uri": compression_exclude_uri,
        "compression-enable": compression_enable,
        "compression-keep-accept-encoding": compression_keep_accept_encoding,
        "failover-url": failover_url,
        "redirect-rewrite": redirect_rewrite,
        "request-header-erase-list": request_header_erase_list,
        "rd-port": rd_port,
        "host-switching": host_switching,
        "url-hash-last": url_hash_last,
        "client-ip-hdr-replace": client_ip_hdr_replace,
        "use-server-status": use_server_status,
        "req-hdr-wait-time-val": req_hdr_wait_time_val,
        "response-header-insert-list": response_header_insert_list,
        "persist-on-401": persist_on_401,
        "redirect": redirect,
        "insert-client-port": insert_client_port,
        "retry-on-5xx-per-req-val": retry_on_5xx_per_req_val,
        "url-hash-offset": url_hash_offset,
        "rd-simple-loc": rd_simple_loc,
        "log-retry": log_retry,
        "non-http-bypass": non_http_bypass,
        "retry-on-5xx-per-req": retry_on_5xx_per_req,
        "insert-client-ip": insert_client_ip,
        "template": template,
        "url-switching": url_switching,
        "insert-client-port-header-name": insert_client_port_header_name,
        "strict-transaction-switch": strict_transaction_switch,
        "response-content-replace-list": response_content_replace_list,
        "100-cont-wait-for-req-complete": http_100_cont_wait_for_req_complete,
        "request-header-insert-list": request_header_insert_list,
        "compression-minimum-content-length": compression_minimum_content_length,
        "compression-level": compression_level,
        "request-line-case-insensitive": request_line_case_insensitive,
        "url-hash-persist": url_hash_persist,
        "response-header-erase-list": response_header_erase_list,
        "uuid": uuid,
        "bypass-sg": bypass_sg,
        "name": a10_name,
        "retry-on-5xx-val": retry_on_5xx_val,
        "url-hash-first": url_hash_first,
        "compression-keep-accept-encoding-enable": compression_keep_accept_encoding_enable,
        "user-tag": user_tag,
        "compression-content-type": compression_content_type,
        "client-port-hdr-replace": client_port_hdr_replace,
        "insert-client-ip-header-name": insert_client_ip_header_name,
        "rd-secure": rd_secure,
        "retry-on-5xx": retry_on_5xx,
        "cookie-format": cookie_format,
        "term-11client-hdr-conn-close": term_11client_hdr_conn_close,
        "compression-exclude-content-type": compression_exclude_content_type,
        "rd-resp-code": rd_resp_code,} }

    params[:"http"].each do |k, v|
        if not v
            params[:"http"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http"].each do |k, v|
        if v != params[:"http"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/http/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http') do
            client.delete(url)
        end
    end
end