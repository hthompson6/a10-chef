resource_name :a10_waf_template

property :a10_name, String, name_property: true
property :log_succ_reqs, [true, false]
property :brute_force_resp_headers_file, String
property :keep_end, Integer
property :max_cookie_len, Integer
property :deploy_mode, ['active','passive','learning']
property :xml_format_check, [true, false]
property :brute_force_resp_string, [true, false]
property :max_string, Integer
property :ccn_mask, [true, false]
property :waf_blist_file, String
property :challenge_action_cookie, [true, false]
property :uuid, String
property :form_set_no_cache, [true, false]
property :http_redirect, String
property :bot_check, [true, false]
property :max_cookies_len, Integer
property :brute_force_global, [true, false]
property :url_check, [true, false]
property :max_parameter_value_len, Integer
property :max_entities, Integer
property :hide_resp_codes, [true, false]
property :max_depth, Integer
property :hide_resp_codes_file, String
property :brute_force_resp_codes_file, String
property :max_elem_name_len, Integer
property :deny_password_autocomplete, [true, false]
property :http_resp_200, [true, false]
property :user_tag, String
property :keep_start, Integer
property :max_hdrs, Integer
property :max_cookie_value_len, Integer
property :max_cdata_len, Integer
property :max_hdr_value_len, Integer
property :secret_encrypted, String
property :cookie_name, String
property :max_namespace_uri_len, Integer
property :resp_url_403, String
property :csrf_check, [true, false]
property :referer_domain_list, String
property :max_parameters, Integer
property :brute_force_lockout_period, Integer
property :max_parameter_name_len, Integer
property :deny_non_masked_passwords, [true, false]
property :challenge_action_javascript, [true, false]
property :max_hdr_name_len, Integer
property :max_elem_depth, Integer
property :form_consistency_check, [true, false]
property :redirect_wlist, [true, false]
property :xml_xss_check, [true, false]
property :referer_check, [true, false]
property :wsdl_resp_val_file, String
property :brute_force_check, [true, false]
property :challenge_action_captcha, [true, false]
property :brute_force_test_period, Integer
property :max_namespace, Integer
property :max_entity_exp, Integer
property :form_deny_non_post, [true, false]
property :cookie_encryption_secret, String
property :decode_escaped_chars, [true, false]
property :json_format_check, [true, false]
property :bot_check_policy_file, String
property :xml_schema_resp_val_file, String
property :brute_force_challenge_limit, Integer
property :allowed_http_methods, String
property :brute_force_resp_codes, [true, false]
property :remove_selfref, [true, false]
property :max_elem_child, Integer
property :max_entity_exp_depth, Integer
property :max_array_value_count, Integer
property :max_elem, Integer
property :sqlia_check, ['reject','sanitize']
property :max_object_member_count, Integer
property :http_resp_403, [true, false]
property :http_check, [true, false]
property :brute_force_resp_headers, [true, false]
property :max_cookie_name_len, Integer
property :remove_comments, [true, false]
property :logging, String
property :uri_wlist_check, [true, false]
property :brute_force_resp_string_file, String
property :form_deny_non_ssl, [true, false]
property :xss_check, ['reject','sanitize']
property :reset_conn, [true, false]
property :referer_safe_url, String
property :remove_spaces, [true, false]
property :brute_force_lockout_limit, Integer
property :uri_blist_check, [true, false]
property :max_url_len, Integer
property :max_hdrs_len, Integer
property :waf_wlist_file, String
property :max_attr_name_len, Integer
property :lifetime, Integer
property :max_attr, Integer
property :xss_check_policy_file, String
property :resp_url_200, String
property :max_post_size, Integer
property :decode_hex_chars, [true, false]
property :max_line_len, Integer
property :max_query_len, Integer
property :sqlia_check_policy_file, String
property :deny_non_ssl_passwords, [true, false]
property :max_data_parse, Integer
property :max_parameter_total_len, Integer
property :wsdl_file, String
property :session_check, [true, false]
property :disable, [true, false]
property :filter_resp_hdrs, [true, false]
property :max_cookies, Integer
property :decode_entities, [true, false]
property :mask, String
property :referer_domain_list_only, String
property :max_attr_value_len, Integer
property :pcre_mask, String
property :soap_format_check, [true, false]
property :xml_schema_file, String
property :ssn_mask, [true, false]
property :xml_sqlia_check, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/waf/template/"
    get_url = "/axapi/v3/waf/template/%<name>s"
    log_succ_reqs = new_resource.log_succ_reqs
    brute_force_resp_headers_file = new_resource.brute_force_resp_headers_file
    keep_end = new_resource.keep_end
    max_cookie_len = new_resource.max_cookie_len
    deploy_mode = new_resource.deploy_mode
    xml_format_check = new_resource.xml_format_check
    brute_force_resp_string = new_resource.brute_force_resp_string
    max_string = new_resource.max_string
    ccn_mask = new_resource.ccn_mask
    waf_blist_file = new_resource.waf_blist_file
    challenge_action_cookie = new_resource.challenge_action_cookie
    uuid = new_resource.uuid
    form_set_no_cache = new_resource.form_set_no_cache
    http_redirect = new_resource.http_redirect
    bot_check = new_resource.bot_check
    max_cookies_len = new_resource.max_cookies_len
    brute_force_global = new_resource.brute_force_global
    url_check = new_resource.url_check
    max_parameter_value_len = new_resource.max_parameter_value_len
    max_entities = new_resource.max_entities
    hide_resp_codes = new_resource.hide_resp_codes
    max_depth = new_resource.max_depth
    hide_resp_codes_file = new_resource.hide_resp_codes_file
    brute_force_resp_codes_file = new_resource.brute_force_resp_codes_file
    max_elem_name_len = new_resource.max_elem_name_len
    deny_password_autocomplete = new_resource.deny_password_autocomplete
    a10_name = new_resource.a10_name
    http_resp_200 = new_resource.http_resp_200
    user_tag = new_resource.user_tag
    keep_start = new_resource.keep_start
    max_hdrs = new_resource.max_hdrs
    max_cookie_value_len = new_resource.max_cookie_value_len
    max_cdata_len = new_resource.max_cdata_len
    max_hdr_value_len = new_resource.max_hdr_value_len
    secret_encrypted = new_resource.secret_encrypted
    cookie_name = new_resource.cookie_name
    max_namespace_uri_len = new_resource.max_namespace_uri_len
    resp_url_403 = new_resource.resp_url_403
    csrf_check = new_resource.csrf_check
    referer_domain_list = new_resource.referer_domain_list
    max_parameters = new_resource.max_parameters
    brute_force_lockout_period = new_resource.brute_force_lockout_period
    max_parameter_name_len = new_resource.max_parameter_name_len
    deny_non_masked_passwords = new_resource.deny_non_masked_passwords
    challenge_action_javascript = new_resource.challenge_action_javascript
    max_hdr_name_len = new_resource.max_hdr_name_len
    max_elem_depth = new_resource.max_elem_depth
    form_consistency_check = new_resource.form_consistency_check
    redirect_wlist = new_resource.redirect_wlist
    xml_xss_check = new_resource.xml_xss_check
    referer_check = new_resource.referer_check
    wsdl_resp_val_file = new_resource.wsdl_resp_val_file
    brute_force_check = new_resource.brute_force_check
    challenge_action_captcha = new_resource.challenge_action_captcha
    brute_force_test_period = new_resource.brute_force_test_period
    max_namespace = new_resource.max_namespace
    max_entity_exp = new_resource.max_entity_exp
    form_deny_non_post = new_resource.form_deny_non_post
    cookie_encryption_secret = new_resource.cookie_encryption_secret
    decode_escaped_chars = new_resource.decode_escaped_chars
    json_format_check = new_resource.json_format_check
    bot_check_policy_file = new_resource.bot_check_policy_file
    xml_schema_resp_val_file = new_resource.xml_schema_resp_val_file
    brute_force_challenge_limit = new_resource.brute_force_challenge_limit
    allowed_http_methods = new_resource.allowed_http_methods
    brute_force_resp_codes = new_resource.brute_force_resp_codes
    remove_selfref = new_resource.remove_selfref
    max_elem_child = new_resource.max_elem_child
    max_entity_exp_depth = new_resource.max_entity_exp_depth
    max_array_value_count = new_resource.max_array_value_count
    max_elem = new_resource.max_elem
    sqlia_check = new_resource.sqlia_check
    max_object_member_count = new_resource.max_object_member_count
    http_resp_403 = new_resource.http_resp_403
    http_check = new_resource.http_check
    brute_force_resp_headers = new_resource.brute_force_resp_headers
    max_cookie_name_len = new_resource.max_cookie_name_len
    remove_comments = new_resource.remove_comments
    logging = new_resource.logging
    uri_wlist_check = new_resource.uri_wlist_check
    brute_force_resp_string_file = new_resource.brute_force_resp_string_file
    form_deny_non_ssl = new_resource.form_deny_non_ssl
    xss_check = new_resource.xss_check
    reset_conn = new_resource.reset_conn
    referer_safe_url = new_resource.referer_safe_url
    remove_spaces = new_resource.remove_spaces
    brute_force_lockout_limit = new_resource.brute_force_lockout_limit
    uri_blist_check = new_resource.uri_blist_check
    max_url_len = new_resource.max_url_len
    max_hdrs_len = new_resource.max_hdrs_len
    waf_wlist_file = new_resource.waf_wlist_file
    max_attr_name_len = new_resource.max_attr_name_len
    lifetime = new_resource.lifetime
    max_attr = new_resource.max_attr
    xss_check_policy_file = new_resource.xss_check_policy_file
    resp_url_200 = new_resource.resp_url_200
    max_post_size = new_resource.max_post_size
    decode_hex_chars = new_resource.decode_hex_chars
    max_line_len = new_resource.max_line_len
    max_query_len = new_resource.max_query_len
    sqlia_check_policy_file = new_resource.sqlia_check_policy_file
    deny_non_ssl_passwords = new_resource.deny_non_ssl_passwords
    max_data_parse = new_resource.max_data_parse
    max_parameter_total_len = new_resource.max_parameter_total_len
    wsdl_file = new_resource.wsdl_file
    session_check = new_resource.session_check
    disable = new_resource.disable
    filter_resp_hdrs = new_resource.filter_resp_hdrs
    max_cookies = new_resource.max_cookies
    decode_entities = new_resource.decode_entities
    mask = new_resource.mask
    referer_domain_list_only = new_resource.referer_domain_list_only
    max_attr_value_len = new_resource.max_attr_value_len
    pcre_mask = new_resource.pcre_mask
    soap_format_check = new_resource.soap_format_check
    xml_schema_file = new_resource.xml_schema_file
    ssn_mask = new_resource.ssn_mask
    xml_sqlia_check = new_resource.xml_sqlia_check

    params = { "template": {"log-succ-reqs": log_succ_reqs,
        "brute-force-resp-headers-file": brute_force_resp_headers_file,
        "keep-end": keep_end,
        "max-cookie-len": max_cookie_len,
        "deploy-mode": deploy_mode,
        "xml-format-check": xml_format_check,
        "brute-force-resp-string": brute_force_resp_string,
        "max-string": max_string,
        "ccn-mask": ccn_mask,
        "waf-blist-file": waf_blist_file,
        "challenge-action-cookie": challenge_action_cookie,
        "uuid": uuid,
        "form-set-no-cache": form_set_no_cache,
        "http-redirect": http_redirect,
        "bot-check": bot_check,
        "max-cookies-len": max_cookies_len,
        "brute-force-global": brute_force_global,
        "url-check": url_check,
        "max-parameter-value-len": max_parameter_value_len,
        "max-entities": max_entities,
        "hide-resp-codes": hide_resp_codes,
        "max-depth": max_depth,
        "hide-resp-codes-file": hide_resp_codes_file,
        "brute-force-resp-codes-file": brute_force_resp_codes_file,
        "max-elem-name-len": max_elem_name_len,
        "deny-password-autocomplete": deny_password_autocomplete,
        "name": a10_name,
        "http-resp-200": http_resp_200,
        "user-tag": user_tag,
        "keep-start": keep_start,
        "max-hdrs": max_hdrs,
        "max-cookie-value-len": max_cookie_value_len,
        "max-cdata-len": max_cdata_len,
        "max-hdr-value-len": max_hdr_value_len,
        "secret-encrypted": secret_encrypted,
        "cookie-name": cookie_name,
        "max-namespace-uri-len": max_namespace_uri_len,
        "resp-url-403": resp_url_403,
        "csrf-check": csrf_check,
        "referer-domain-list": referer_domain_list,
        "max-parameters": max_parameters,
        "brute-force-lockout-period": brute_force_lockout_period,
        "max-parameter-name-len": max_parameter_name_len,
        "deny-non-masked-passwords": deny_non_masked_passwords,
        "challenge-action-javascript": challenge_action_javascript,
        "max-hdr-name-len": max_hdr_name_len,
        "max-elem-depth": max_elem_depth,
        "form-consistency-check": form_consistency_check,
        "redirect-wlist": redirect_wlist,
        "xml-xss-check": xml_xss_check,
        "referer-check": referer_check,
        "wsdl-resp-val-file": wsdl_resp_val_file,
        "brute-force-check": brute_force_check,
        "challenge-action-captcha": challenge_action_captcha,
        "brute-force-test-period": brute_force_test_period,
        "max-namespace": max_namespace,
        "max-entity-exp": max_entity_exp,
        "form-deny-non-post": form_deny_non_post,
        "cookie-encryption-secret": cookie_encryption_secret,
        "decode-escaped-chars": decode_escaped_chars,
        "json-format-check": json_format_check,
        "bot-check-policy-file": bot_check_policy_file,
        "xml-schema-resp-val-file": xml_schema_resp_val_file,
        "brute-force-challenge-limit": brute_force_challenge_limit,
        "allowed-http-methods": allowed_http_methods,
        "brute-force-resp-codes": brute_force_resp_codes,
        "remove-selfref": remove_selfref,
        "max-elem-child": max_elem_child,
        "max-entity-exp-depth": max_entity_exp_depth,
        "max-array-value-count": max_array_value_count,
        "max-elem": max_elem,
        "sqlia-check": sqlia_check,
        "max-object-member-count": max_object_member_count,
        "http-resp-403": http_resp_403,
        "http-check": http_check,
        "brute-force-resp-headers": brute_force_resp_headers,
        "max-cookie-name-len": max_cookie_name_len,
        "remove-comments": remove_comments,
        "logging": logging,
        "uri-wlist-check": uri_wlist_check,
        "brute-force-resp-string-file": brute_force_resp_string_file,
        "form-deny-non-ssl": form_deny_non_ssl,
        "xss-check": xss_check,
        "reset-conn": reset_conn,
        "referer-safe-url": referer_safe_url,
        "remove-spaces": remove_spaces,
        "brute-force-lockout-limit": brute_force_lockout_limit,
        "uri-blist-check": uri_blist_check,
        "max-url-len": max_url_len,
        "max-hdrs-len": max_hdrs_len,
        "waf-wlist-file": waf_wlist_file,
        "max-attr-name-len": max_attr_name_len,
        "lifetime": lifetime,
        "max-attr": max_attr,
        "xss-check-policy-file": xss_check_policy_file,
        "resp-url-200": resp_url_200,
        "max-post-size": max_post_size,
        "decode-hex-chars": decode_hex_chars,
        "max-line-len": max_line_len,
        "max-query-len": max_query_len,
        "sqlia-check-policy-file": sqlia_check_policy_file,
        "deny-non-ssl-passwords": deny_non_ssl_passwords,
        "max-data-parse": max_data_parse,
        "max-parameter-total-len": max_parameter_total_len,
        "wsdl-file": wsdl_file,
        "session-check": session_check,
        "disable": disable,
        "filter-resp-hdrs": filter_resp_hdrs,
        "max-cookies": max_cookies,
        "decode-entities": decode_entities,
        "mask": mask,
        "referer-domain-list-only": referer_domain_list_only,
        "max-attr-value-len": max_attr_value_len,
        "pcre-mask": pcre_mask,
        "soap-format-check": soap_format_check,
        "xml-schema-file": xml_schema_file,
        "ssn-mask": ssn_mask,
        "xml-sqlia-check": xml_sqlia_check,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/template/%<name>s"
    log_succ_reqs = new_resource.log_succ_reqs
    brute_force_resp_headers_file = new_resource.brute_force_resp_headers_file
    keep_end = new_resource.keep_end
    max_cookie_len = new_resource.max_cookie_len
    deploy_mode = new_resource.deploy_mode
    xml_format_check = new_resource.xml_format_check
    brute_force_resp_string = new_resource.brute_force_resp_string
    max_string = new_resource.max_string
    ccn_mask = new_resource.ccn_mask
    waf_blist_file = new_resource.waf_blist_file
    challenge_action_cookie = new_resource.challenge_action_cookie
    uuid = new_resource.uuid
    form_set_no_cache = new_resource.form_set_no_cache
    http_redirect = new_resource.http_redirect
    bot_check = new_resource.bot_check
    max_cookies_len = new_resource.max_cookies_len
    brute_force_global = new_resource.brute_force_global
    url_check = new_resource.url_check
    max_parameter_value_len = new_resource.max_parameter_value_len
    max_entities = new_resource.max_entities
    hide_resp_codes = new_resource.hide_resp_codes
    max_depth = new_resource.max_depth
    hide_resp_codes_file = new_resource.hide_resp_codes_file
    brute_force_resp_codes_file = new_resource.brute_force_resp_codes_file
    max_elem_name_len = new_resource.max_elem_name_len
    deny_password_autocomplete = new_resource.deny_password_autocomplete
    a10_name = new_resource.a10_name
    http_resp_200 = new_resource.http_resp_200
    user_tag = new_resource.user_tag
    keep_start = new_resource.keep_start
    max_hdrs = new_resource.max_hdrs
    max_cookie_value_len = new_resource.max_cookie_value_len
    max_cdata_len = new_resource.max_cdata_len
    max_hdr_value_len = new_resource.max_hdr_value_len
    secret_encrypted = new_resource.secret_encrypted
    cookie_name = new_resource.cookie_name
    max_namespace_uri_len = new_resource.max_namespace_uri_len
    resp_url_403 = new_resource.resp_url_403
    csrf_check = new_resource.csrf_check
    referer_domain_list = new_resource.referer_domain_list
    max_parameters = new_resource.max_parameters
    brute_force_lockout_period = new_resource.brute_force_lockout_period
    max_parameter_name_len = new_resource.max_parameter_name_len
    deny_non_masked_passwords = new_resource.deny_non_masked_passwords
    challenge_action_javascript = new_resource.challenge_action_javascript
    max_hdr_name_len = new_resource.max_hdr_name_len
    max_elem_depth = new_resource.max_elem_depth
    form_consistency_check = new_resource.form_consistency_check
    redirect_wlist = new_resource.redirect_wlist
    xml_xss_check = new_resource.xml_xss_check
    referer_check = new_resource.referer_check
    wsdl_resp_val_file = new_resource.wsdl_resp_val_file
    brute_force_check = new_resource.brute_force_check
    challenge_action_captcha = new_resource.challenge_action_captcha
    brute_force_test_period = new_resource.brute_force_test_period
    max_namespace = new_resource.max_namespace
    max_entity_exp = new_resource.max_entity_exp
    form_deny_non_post = new_resource.form_deny_non_post
    cookie_encryption_secret = new_resource.cookie_encryption_secret
    decode_escaped_chars = new_resource.decode_escaped_chars
    json_format_check = new_resource.json_format_check
    bot_check_policy_file = new_resource.bot_check_policy_file
    xml_schema_resp_val_file = new_resource.xml_schema_resp_val_file
    brute_force_challenge_limit = new_resource.brute_force_challenge_limit
    allowed_http_methods = new_resource.allowed_http_methods
    brute_force_resp_codes = new_resource.brute_force_resp_codes
    remove_selfref = new_resource.remove_selfref
    max_elem_child = new_resource.max_elem_child
    max_entity_exp_depth = new_resource.max_entity_exp_depth
    max_array_value_count = new_resource.max_array_value_count
    max_elem = new_resource.max_elem
    sqlia_check = new_resource.sqlia_check
    max_object_member_count = new_resource.max_object_member_count
    http_resp_403 = new_resource.http_resp_403
    http_check = new_resource.http_check
    brute_force_resp_headers = new_resource.brute_force_resp_headers
    max_cookie_name_len = new_resource.max_cookie_name_len
    remove_comments = new_resource.remove_comments
    logging = new_resource.logging
    uri_wlist_check = new_resource.uri_wlist_check
    brute_force_resp_string_file = new_resource.brute_force_resp_string_file
    form_deny_non_ssl = new_resource.form_deny_non_ssl
    xss_check = new_resource.xss_check
    reset_conn = new_resource.reset_conn
    referer_safe_url = new_resource.referer_safe_url
    remove_spaces = new_resource.remove_spaces
    brute_force_lockout_limit = new_resource.brute_force_lockout_limit
    uri_blist_check = new_resource.uri_blist_check
    max_url_len = new_resource.max_url_len
    max_hdrs_len = new_resource.max_hdrs_len
    waf_wlist_file = new_resource.waf_wlist_file
    max_attr_name_len = new_resource.max_attr_name_len
    lifetime = new_resource.lifetime
    max_attr = new_resource.max_attr
    xss_check_policy_file = new_resource.xss_check_policy_file
    resp_url_200 = new_resource.resp_url_200
    max_post_size = new_resource.max_post_size
    decode_hex_chars = new_resource.decode_hex_chars
    max_line_len = new_resource.max_line_len
    max_query_len = new_resource.max_query_len
    sqlia_check_policy_file = new_resource.sqlia_check_policy_file
    deny_non_ssl_passwords = new_resource.deny_non_ssl_passwords
    max_data_parse = new_resource.max_data_parse
    max_parameter_total_len = new_resource.max_parameter_total_len
    wsdl_file = new_resource.wsdl_file
    session_check = new_resource.session_check
    disable = new_resource.disable
    filter_resp_hdrs = new_resource.filter_resp_hdrs
    max_cookies = new_resource.max_cookies
    decode_entities = new_resource.decode_entities
    mask = new_resource.mask
    referer_domain_list_only = new_resource.referer_domain_list_only
    max_attr_value_len = new_resource.max_attr_value_len
    pcre_mask = new_resource.pcre_mask
    soap_format_check = new_resource.soap_format_check
    xml_schema_file = new_resource.xml_schema_file
    ssn_mask = new_resource.ssn_mask
    xml_sqlia_check = new_resource.xml_sqlia_check

    params = { "template": {"log-succ-reqs": log_succ_reqs,
        "brute-force-resp-headers-file": brute_force_resp_headers_file,
        "keep-end": keep_end,
        "max-cookie-len": max_cookie_len,
        "deploy-mode": deploy_mode,
        "xml-format-check": xml_format_check,
        "brute-force-resp-string": brute_force_resp_string,
        "max-string": max_string,
        "ccn-mask": ccn_mask,
        "waf-blist-file": waf_blist_file,
        "challenge-action-cookie": challenge_action_cookie,
        "uuid": uuid,
        "form-set-no-cache": form_set_no_cache,
        "http-redirect": http_redirect,
        "bot-check": bot_check,
        "max-cookies-len": max_cookies_len,
        "brute-force-global": brute_force_global,
        "url-check": url_check,
        "max-parameter-value-len": max_parameter_value_len,
        "max-entities": max_entities,
        "hide-resp-codes": hide_resp_codes,
        "max-depth": max_depth,
        "hide-resp-codes-file": hide_resp_codes_file,
        "brute-force-resp-codes-file": brute_force_resp_codes_file,
        "max-elem-name-len": max_elem_name_len,
        "deny-password-autocomplete": deny_password_autocomplete,
        "name": a10_name,
        "http-resp-200": http_resp_200,
        "user-tag": user_tag,
        "keep-start": keep_start,
        "max-hdrs": max_hdrs,
        "max-cookie-value-len": max_cookie_value_len,
        "max-cdata-len": max_cdata_len,
        "max-hdr-value-len": max_hdr_value_len,
        "secret-encrypted": secret_encrypted,
        "cookie-name": cookie_name,
        "max-namespace-uri-len": max_namespace_uri_len,
        "resp-url-403": resp_url_403,
        "csrf-check": csrf_check,
        "referer-domain-list": referer_domain_list,
        "max-parameters": max_parameters,
        "brute-force-lockout-period": brute_force_lockout_period,
        "max-parameter-name-len": max_parameter_name_len,
        "deny-non-masked-passwords": deny_non_masked_passwords,
        "challenge-action-javascript": challenge_action_javascript,
        "max-hdr-name-len": max_hdr_name_len,
        "max-elem-depth": max_elem_depth,
        "form-consistency-check": form_consistency_check,
        "redirect-wlist": redirect_wlist,
        "xml-xss-check": xml_xss_check,
        "referer-check": referer_check,
        "wsdl-resp-val-file": wsdl_resp_val_file,
        "brute-force-check": brute_force_check,
        "challenge-action-captcha": challenge_action_captcha,
        "brute-force-test-period": brute_force_test_period,
        "max-namespace": max_namespace,
        "max-entity-exp": max_entity_exp,
        "form-deny-non-post": form_deny_non_post,
        "cookie-encryption-secret": cookie_encryption_secret,
        "decode-escaped-chars": decode_escaped_chars,
        "json-format-check": json_format_check,
        "bot-check-policy-file": bot_check_policy_file,
        "xml-schema-resp-val-file": xml_schema_resp_val_file,
        "brute-force-challenge-limit": brute_force_challenge_limit,
        "allowed-http-methods": allowed_http_methods,
        "brute-force-resp-codes": brute_force_resp_codes,
        "remove-selfref": remove_selfref,
        "max-elem-child": max_elem_child,
        "max-entity-exp-depth": max_entity_exp_depth,
        "max-array-value-count": max_array_value_count,
        "max-elem": max_elem,
        "sqlia-check": sqlia_check,
        "max-object-member-count": max_object_member_count,
        "http-resp-403": http_resp_403,
        "http-check": http_check,
        "brute-force-resp-headers": brute_force_resp_headers,
        "max-cookie-name-len": max_cookie_name_len,
        "remove-comments": remove_comments,
        "logging": logging,
        "uri-wlist-check": uri_wlist_check,
        "brute-force-resp-string-file": brute_force_resp_string_file,
        "form-deny-non-ssl": form_deny_non_ssl,
        "xss-check": xss_check,
        "reset-conn": reset_conn,
        "referer-safe-url": referer_safe_url,
        "remove-spaces": remove_spaces,
        "brute-force-lockout-limit": brute_force_lockout_limit,
        "uri-blist-check": uri_blist_check,
        "max-url-len": max_url_len,
        "max-hdrs-len": max_hdrs_len,
        "waf-wlist-file": waf_wlist_file,
        "max-attr-name-len": max_attr_name_len,
        "lifetime": lifetime,
        "max-attr": max_attr,
        "xss-check-policy-file": xss_check_policy_file,
        "resp-url-200": resp_url_200,
        "max-post-size": max_post_size,
        "decode-hex-chars": decode_hex_chars,
        "max-line-len": max_line_len,
        "max-query-len": max_query_len,
        "sqlia-check-policy-file": sqlia_check_policy_file,
        "deny-non-ssl-passwords": deny_non_ssl_passwords,
        "max-data-parse": max_data_parse,
        "max-parameter-total-len": max_parameter_total_len,
        "wsdl-file": wsdl_file,
        "session-check": session_check,
        "disable": disable,
        "filter-resp-hdrs": filter_resp_hdrs,
        "max-cookies": max_cookies,
        "decode-entities": decode_entities,
        "mask": mask,
        "referer-domain-list-only": referer_domain_list_only,
        "max-attr-value-len": max_attr_value_len,
        "pcre-mask": pcre_mask,
        "soap-format-check": soap_format_check,
        "xml-schema-file": xml_schema_file,
        "ssn-mask": ssn_mask,
        "xml-sqlia-check": xml_sqlia_check,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end