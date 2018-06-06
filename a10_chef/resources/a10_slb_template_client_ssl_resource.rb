resource_name :a10_slb_template_client_ssl

property :a10_name, String, name_property: true
property :verify_cert_fail_action, ['bypass','continue','drop']
property :forward_proxy_cert_revoke_action, [true, false]
property :ocspst_sg_hours, Integer
property :fp_cert_fetch_autonat, ['auto']
property :equals_list, Array
property :uuid, String
property :forward_proxy_trusted_ca_lists, Array
property :forward_proxy_ca_cert, String
property :ssl_false_start_disable, [true, false]
property :dgversion, Integer
property :ec_list, Array
property :key_encrypted, String
property :notafteryear, Integer
property :forward_proxy_alt_sign, [true, false]
property :template_hsm, String
property :forward_passphrase, String
property :contains_list, Array
property :forward_proxy_ca_key, String
property :notbefore, [true, false]
property :ends_with_list, Array
property :notafter, [true, false]
property :class_list_name, String
property :ocspst_ocsp, [true, false]
property :notbeforeday, Integer
property :forward_proxy_ssl_version, Integer
property :ca_certs, Array
property :forward_proxy_crl_disable, [true, false]
property :client_auth_contains_list, Array
property :fp_cert_ext_aia_ocsp, String
property :req_ca_lists, Array
property :user_tag, String
property :cert_unknown_action, ['bypass','continue','drop']
property :renegotiation_disable, [true, false]
property :fp_alt_key, String
property :server_name_auto_map, [true, false]
property :disable_sslv3, [true, false]
property :client_auth_equals_list, Array
property :fp_alt_passphrase, String
property :forward_proxy_cert_cache_timeout, Integer
property :crl_certs, Array
property :notafterday, Integer
property :ocspst_srvr_hours, Integer
property :local_logging, [true, false]
property :fp_cert_fetch_autonat_precedence, [true, false]
property :cert_revoke_action, ['bypass','continue','drop']
property :version, Integer
property :multi_class_list, Array
property :session_ticket_lifetime, Integer
property :ssli_logging, [true, false]
property :session_cache_size, Integer
property :non_ssl_bypass_service_group, String
property :forward_proxy_failsafe_disable, [true, false]
property :session_cache_timeout, Integer
property :sslv2_bypass_service_group, String
property :forward_proxy_decrypted_dscp, Integer
property :auth_sg, String
property :ocspst_ca_cert, String
property :forward_proxy_selfsign_redir, [true, false]
property :auth_sg_dn, [true, false]
property :hsm_type, ['thales-embed','thales-hwcrhk']
property :forward_proxy_log_disable, [true, false]
property :fp_alt_encrypted, String
property :cert, String
property :web_category, Hash
property :template_cipher, String
property :notbeforemonth, Integer
property :chain_cert, String
property :forward_proxy_cert_unknown_action, [true, false]
property :key, String
property :ocspst_sg, String
property :fp_cert_ext_aia_ca_issuers, String
property :authen_name, String
property :expire_hours, Integer
property :client_auth_case_insensitive, [true, false]
property :ocsp_stapling, [true, false]
property :notbeforeyear, Integer
property :forward_encrypted, String
property :sni_enable_log, [true, false]
property :notaftermonth, Integer
property :cache_persistence_list_name, String
property :ocspst_sg_timeout, Integer
property :key_passphrase, String
property :ocspst_srvr, String
property :ocspst_srvr_minutes, Integer
property :client_auth_starts_with_list, Array
property :authorization, [true, false]
property :forward_proxy_verify_cert_fail_action, [true, false]
property :ocspst_srvr_days, Integer
property :client_auth_class_list, String
property :forward_proxy_decrypted_dscp_bypass, Integer
property :alert_type, ['fatal']
property :forward_proxy_cert_not_ready_action, ['bypass','reset']
property :server_name_list, Array
property :fp_cert_fetch_natpool_precedence, [true, false]
property :forward_proxy_cert_cache_limit, Integer
property :handshake_logging_enable, [true, false]
property :client_auth_ends_with_list, Array
property :close_notify, [true, false]
property :forward_proxy_ocsp_disable, [true, false]
property :sslilogging, ['disable','all']
property :auth_username, String
property :fp_cert_ext_crldp, String
property :ocspst_sg_days, Integer
property :inspect_list_name, String
property :auth_username_attribute, String
property :fp_cert_fetch_natpool_name, String
property :ldap_base_dn_from_cert, [true, false]
property :client_certificate, ['Ignore','Require','Request']
property :forward_proxy_cert_expiry, [true, false]
property :forward_proxy_enable, [true, false]
property :ldap_search_filter, String
property :auth_sg_filter, String
property :ocspst_srvr_timeout, Integer
property :enable_tls_alert_logging, [true, false]
property :exception_class_list, String
property :dh_type, ['1024','1024-dsa','2048']
property :fp_alt_cert, String
property :case_insensitive, [true, false]
property :cipher_without_prio_list, Array
property :ocspst_sg_minutes, Integer
property :starts_with_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/client-ssl/"
    get_url = "/axapi/v3/slb/template/client-ssl/%<name>s"
    verify_cert_fail_action = new_resource.verify_cert_fail_action
    forward_proxy_cert_revoke_action = new_resource.forward_proxy_cert_revoke_action
    ocspst_sg_hours = new_resource.ocspst_sg_hours
    fp_cert_fetch_autonat = new_resource.fp_cert_fetch_autonat
    equals_list = new_resource.equals_list
    uuid = new_resource.uuid
    forward_proxy_trusted_ca_lists = new_resource.forward_proxy_trusted_ca_lists
    forward_proxy_ca_cert = new_resource.forward_proxy_ca_cert
    ssl_false_start_disable = new_resource.ssl_false_start_disable
    dgversion = new_resource.dgversion
    ec_list = new_resource.ec_list
    key_encrypted = new_resource.key_encrypted
    notafteryear = new_resource.notafteryear
    forward_proxy_alt_sign = new_resource.forward_proxy_alt_sign
    template_hsm = new_resource.template_hsm
    forward_passphrase = new_resource.forward_passphrase
    contains_list = new_resource.contains_list
    forward_proxy_ca_key = new_resource.forward_proxy_ca_key
    notbefore = new_resource.notbefore
    ends_with_list = new_resource.ends_with_list
    notafter = new_resource.notafter
    class_list_name = new_resource.class_list_name
    ocspst_ocsp = new_resource.ocspst_ocsp
    notbeforeday = new_resource.notbeforeday
    forward_proxy_ssl_version = new_resource.forward_proxy_ssl_version
    ca_certs = new_resource.ca_certs
    forward_proxy_crl_disable = new_resource.forward_proxy_crl_disable
    client_auth_contains_list = new_resource.client_auth_contains_list
    a10_name = new_resource.a10_name
    fp_cert_ext_aia_ocsp = new_resource.fp_cert_ext_aia_ocsp
    req_ca_lists = new_resource.req_ca_lists
    user_tag = new_resource.user_tag
    cert_unknown_action = new_resource.cert_unknown_action
    renegotiation_disable = new_resource.renegotiation_disable
    fp_alt_key = new_resource.fp_alt_key
    server_name_auto_map = new_resource.server_name_auto_map
    disable_sslv3 = new_resource.disable_sslv3
    client_auth_equals_list = new_resource.client_auth_equals_list
    fp_alt_passphrase = new_resource.fp_alt_passphrase
    forward_proxy_cert_cache_timeout = new_resource.forward_proxy_cert_cache_timeout
    crl_certs = new_resource.crl_certs
    notafterday = new_resource.notafterday
    ocspst_srvr_hours = new_resource.ocspst_srvr_hours
    local_logging = new_resource.local_logging
    fp_cert_fetch_autonat_precedence = new_resource.fp_cert_fetch_autonat_precedence
    cert_revoke_action = new_resource.cert_revoke_action
    version = new_resource.version
    multi_class_list = new_resource.multi_class_list
    session_ticket_lifetime = new_resource.session_ticket_lifetime
    ssli_logging = new_resource.ssli_logging
    session_cache_size = new_resource.session_cache_size
    non_ssl_bypass_service_group = new_resource.non_ssl_bypass_service_group
    forward_proxy_failsafe_disable = new_resource.forward_proxy_failsafe_disable
    session_cache_timeout = new_resource.session_cache_timeout
    sslv2_bypass_service_group = new_resource.sslv2_bypass_service_group
    forward_proxy_decrypted_dscp = new_resource.forward_proxy_decrypted_dscp
    auth_sg = new_resource.auth_sg
    ocspst_ca_cert = new_resource.ocspst_ca_cert
    forward_proxy_selfsign_redir = new_resource.forward_proxy_selfsign_redir
    auth_sg_dn = new_resource.auth_sg_dn
    hsm_type = new_resource.hsm_type
    forward_proxy_log_disable = new_resource.forward_proxy_log_disable
    fp_alt_encrypted = new_resource.fp_alt_encrypted
    cert = new_resource.cert
    web_category = new_resource.web_category
    template_cipher = new_resource.template_cipher
    notbeforemonth = new_resource.notbeforemonth
    chain_cert = new_resource.chain_cert
    forward_proxy_cert_unknown_action = new_resource.forward_proxy_cert_unknown_action
    key = new_resource.key
    ocspst_sg = new_resource.ocspst_sg
    fp_cert_ext_aia_ca_issuers = new_resource.fp_cert_ext_aia_ca_issuers
    authen_name = new_resource.authen_name
    expire_hours = new_resource.expire_hours
    client_auth_case_insensitive = new_resource.client_auth_case_insensitive
    ocsp_stapling = new_resource.ocsp_stapling
    notbeforeyear = new_resource.notbeforeyear
    forward_encrypted = new_resource.forward_encrypted
    sni_enable_log = new_resource.sni_enable_log
    notaftermonth = new_resource.notaftermonth
    cache_persistence_list_name = new_resource.cache_persistence_list_name
    ocspst_sg_timeout = new_resource.ocspst_sg_timeout
    key_passphrase = new_resource.key_passphrase
    ocspst_srvr = new_resource.ocspst_srvr
    ocspst_srvr_minutes = new_resource.ocspst_srvr_minutes
    client_auth_starts_with_list = new_resource.client_auth_starts_with_list
    authorization = new_resource.authorization
    forward_proxy_verify_cert_fail_action = new_resource.forward_proxy_verify_cert_fail_action
    ocspst_srvr_days = new_resource.ocspst_srvr_days
    client_auth_class_list = new_resource.client_auth_class_list
    forward_proxy_decrypted_dscp_bypass = new_resource.forward_proxy_decrypted_dscp_bypass
    alert_type = new_resource.alert_type
    forward_proxy_cert_not_ready_action = new_resource.forward_proxy_cert_not_ready_action
    server_name_list = new_resource.server_name_list
    fp_cert_fetch_natpool_precedence = new_resource.fp_cert_fetch_natpool_precedence
    forward_proxy_cert_cache_limit = new_resource.forward_proxy_cert_cache_limit
    handshake_logging_enable = new_resource.handshake_logging_enable
    client_auth_ends_with_list = new_resource.client_auth_ends_with_list
    close_notify = new_resource.close_notify
    forward_proxy_ocsp_disable = new_resource.forward_proxy_ocsp_disable
    sslilogging = new_resource.sslilogging
    auth_username = new_resource.auth_username
    fp_cert_ext_crldp = new_resource.fp_cert_ext_crldp
    ocspst_sg_days = new_resource.ocspst_sg_days
    inspect_list_name = new_resource.inspect_list_name
    auth_username_attribute = new_resource.auth_username_attribute
    fp_cert_fetch_natpool_name = new_resource.fp_cert_fetch_natpool_name
    ldap_base_dn_from_cert = new_resource.ldap_base_dn_from_cert
    client_certificate = new_resource.client_certificate
    forward_proxy_cert_expiry = new_resource.forward_proxy_cert_expiry
    forward_proxy_enable = new_resource.forward_proxy_enable
    ldap_search_filter = new_resource.ldap_search_filter
    auth_sg_filter = new_resource.auth_sg_filter
    ocspst_srvr_timeout = new_resource.ocspst_srvr_timeout
    enable_tls_alert_logging = new_resource.enable_tls_alert_logging
    exception_class_list = new_resource.exception_class_list
    dh_type = new_resource.dh_type
    fp_alt_cert = new_resource.fp_alt_cert
    case_insensitive = new_resource.case_insensitive
    cipher_without_prio_list = new_resource.cipher_without_prio_list
    ocspst_sg_minutes = new_resource.ocspst_sg_minutes
    starts_with_list = new_resource.starts_with_list

    params = { "client-ssl": {"verify-cert-fail-action": verify_cert_fail_action,
        "forward-proxy-cert-revoke-action": forward_proxy_cert_revoke_action,
        "ocspst-sg-hours": ocspst_sg_hours,
        "fp-cert-fetch-autonat": fp_cert_fetch_autonat,
        "equals-list": equals_list,
        "uuid": uuid,
        "forward-proxy-trusted-ca-lists": forward_proxy_trusted_ca_lists,
        "forward-proxy-ca-cert": forward_proxy_ca_cert,
        "ssl-false-start-disable": ssl_false_start_disable,
        "dgversion": dgversion,
        "ec-list": ec_list,
        "key-encrypted": key_encrypted,
        "notafteryear": notafteryear,
        "forward-proxy-alt-sign": forward_proxy_alt_sign,
        "template-hsm": template_hsm,
        "forward-passphrase": forward_passphrase,
        "contains-list": contains_list,
        "forward-proxy-ca-key": forward_proxy_ca_key,
        "notbefore": notbefore,
        "ends-with-list": ends_with_list,
        "notafter": notafter,
        "class-list-name": class_list_name,
        "ocspst-ocsp": ocspst_ocsp,
        "notbeforeday": notbeforeday,
        "forward-proxy-ssl-version": forward_proxy_ssl_version,
        "ca-certs": ca_certs,
        "forward-proxy-crl-disable": forward_proxy_crl_disable,
        "client-auth-contains-list": client_auth_contains_list,
        "name": a10_name,
        "fp-cert-ext-aia-ocsp": fp_cert_ext_aia_ocsp,
        "req-ca-lists": req_ca_lists,
        "user-tag": user_tag,
        "cert-unknown-action": cert_unknown_action,
        "renegotiation-disable": renegotiation_disable,
        "fp-alt-key": fp_alt_key,
        "server-name-auto-map": server_name_auto_map,
        "disable-sslv3": disable_sslv3,
        "client-auth-equals-list": client_auth_equals_list,
        "fp-alt-passphrase": fp_alt_passphrase,
        "forward-proxy-cert-cache-timeout": forward_proxy_cert_cache_timeout,
        "crl-certs": crl_certs,
        "notafterday": notafterday,
        "ocspst-srvr-hours": ocspst_srvr_hours,
        "local-logging": local_logging,
        "fp-cert-fetch-autonat-precedence": fp_cert_fetch_autonat_precedence,
        "cert-revoke-action": cert_revoke_action,
        "version": version,
        "multi-class-list": multi_class_list,
        "session-ticket-lifetime": session_ticket_lifetime,
        "ssli-logging": ssli_logging,
        "session-cache-size": session_cache_size,
        "non-ssl-bypass-service-group": non_ssl_bypass_service_group,
        "forward-proxy-failsafe-disable": forward_proxy_failsafe_disable,
        "session-cache-timeout": session_cache_timeout,
        "sslv2-bypass-service-group": sslv2_bypass_service_group,
        "forward-proxy-decrypted-dscp": forward_proxy_decrypted_dscp,
        "auth-sg": auth_sg,
        "ocspst-ca-cert": ocspst_ca_cert,
        "forward-proxy-selfsign-redir": forward_proxy_selfsign_redir,
        "auth-sg-dn": auth_sg_dn,
        "hsm-type": hsm_type,
        "forward-proxy-log-disable": forward_proxy_log_disable,
        "fp-alt-encrypted": fp_alt_encrypted,
        "cert": cert,
        "web-category": web_category,
        "template-cipher": template_cipher,
        "notbeforemonth": notbeforemonth,
        "chain-cert": chain_cert,
        "forward-proxy-cert-unknown-action": forward_proxy_cert_unknown_action,
        "key": key,
        "ocspst-sg": ocspst_sg,
        "fp-cert-ext-aia-ca-issuers": fp_cert_ext_aia_ca_issuers,
        "authen-name": authen_name,
        "expire-hours": expire_hours,
        "client-auth-case-insensitive": client_auth_case_insensitive,
        "ocsp-stapling": ocsp_stapling,
        "notbeforeyear": notbeforeyear,
        "forward-encrypted": forward_encrypted,
        "sni-enable-log": sni_enable_log,
        "notaftermonth": notaftermonth,
        "cache-persistence-list-name": cache_persistence_list_name,
        "ocspst-sg-timeout": ocspst_sg_timeout,
        "key-passphrase": key_passphrase,
        "ocspst-srvr": ocspst_srvr,
        "ocspst-srvr-minutes": ocspst_srvr_minutes,
        "client-auth-starts-with-list": client_auth_starts_with_list,
        "authorization": authorization,
        "forward-proxy-verify-cert-fail-action": forward_proxy_verify_cert_fail_action,
        "ocspst-srvr-days": ocspst_srvr_days,
        "client-auth-class-list": client_auth_class_list,
        "forward-proxy-decrypted-dscp-bypass": forward_proxy_decrypted_dscp_bypass,
        "alert-type": alert_type,
        "forward-proxy-cert-not-ready-action": forward_proxy_cert_not_ready_action,
        "server-name-list": server_name_list,
        "fp-cert-fetch-natpool-precedence": fp_cert_fetch_natpool_precedence,
        "forward-proxy-cert-cache-limit": forward_proxy_cert_cache_limit,
        "handshake-logging-enable": handshake_logging_enable,
        "client-auth-ends-with-list": client_auth_ends_with_list,
        "close-notify": close_notify,
        "forward-proxy-ocsp-disable": forward_proxy_ocsp_disable,
        "sslilogging": sslilogging,
        "auth-username": auth_username,
        "fp-cert-ext-crldp": fp_cert_ext_crldp,
        "ocspst-sg-days": ocspst_sg_days,
        "inspect-list-name": inspect_list_name,
        "auth-username-attribute": auth_username_attribute,
        "fp-cert-fetch-natpool-name": fp_cert_fetch_natpool_name,
        "ldap-base-dn-from-cert": ldap_base_dn_from_cert,
        "client-certificate": client_certificate,
        "forward-proxy-cert-expiry": forward_proxy_cert_expiry,
        "forward-proxy-enable": forward_proxy_enable,
        "ldap-search-filter": ldap_search_filter,
        "auth-sg-filter": auth_sg_filter,
        "ocspst-srvr-timeout": ocspst_srvr_timeout,
        "enable-tls-alert-logging": enable_tls_alert_logging,
        "exception-class-list": exception_class_list,
        "dh-type": dh_type,
        "fp-alt-cert": fp_alt_cert,
        "case-insensitive": case_insensitive,
        "cipher-without-prio-list": cipher_without_prio_list,
        "ocspst-sg-minutes": ocspst_sg_minutes,
        "starts-with-list": starts_with_list,} }

    params[:"client-ssl"].each do |k, v|
        if not v 
            params[:"client-ssl"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating client-ssl') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/client-ssl/%<name>s"
    verify_cert_fail_action = new_resource.verify_cert_fail_action
    forward_proxy_cert_revoke_action = new_resource.forward_proxy_cert_revoke_action
    ocspst_sg_hours = new_resource.ocspst_sg_hours
    fp_cert_fetch_autonat = new_resource.fp_cert_fetch_autonat
    equals_list = new_resource.equals_list
    uuid = new_resource.uuid
    forward_proxy_trusted_ca_lists = new_resource.forward_proxy_trusted_ca_lists
    forward_proxy_ca_cert = new_resource.forward_proxy_ca_cert
    ssl_false_start_disable = new_resource.ssl_false_start_disable
    dgversion = new_resource.dgversion
    ec_list = new_resource.ec_list
    key_encrypted = new_resource.key_encrypted
    notafteryear = new_resource.notafteryear
    forward_proxy_alt_sign = new_resource.forward_proxy_alt_sign
    template_hsm = new_resource.template_hsm
    forward_passphrase = new_resource.forward_passphrase
    contains_list = new_resource.contains_list
    forward_proxy_ca_key = new_resource.forward_proxy_ca_key
    notbefore = new_resource.notbefore
    ends_with_list = new_resource.ends_with_list
    notafter = new_resource.notafter
    class_list_name = new_resource.class_list_name
    ocspst_ocsp = new_resource.ocspst_ocsp
    notbeforeday = new_resource.notbeforeday
    forward_proxy_ssl_version = new_resource.forward_proxy_ssl_version
    ca_certs = new_resource.ca_certs
    forward_proxy_crl_disable = new_resource.forward_proxy_crl_disable
    client_auth_contains_list = new_resource.client_auth_contains_list
    a10_name = new_resource.a10_name
    fp_cert_ext_aia_ocsp = new_resource.fp_cert_ext_aia_ocsp
    req_ca_lists = new_resource.req_ca_lists
    user_tag = new_resource.user_tag
    cert_unknown_action = new_resource.cert_unknown_action
    renegotiation_disable = new_resource.renegotiation_disable
    fp_alt_key = new_resource.fp_alt_key
    server_name_auto_map = new_resource.server_name_auto_map
    disable_sslv3 = new_resource.disable_sslv3
    client_auth_equals_list = new_resource.client_auth_equals_list
    fp_alt_passphrase = new_resource.fp_alt_passphrase
    forward_proxy_cert_cache_timeout = new_resource.forward_proxy_cert_cache_timeout
    crl_certs = new_resource.crl_certs
    notafterday = new_resource.notafterday
    ocspst_srvr_hours = new_resource.ocspst_srvr_hours
    local_logging = new_resource.local_logging
    fp_cert_fetch_autonat_precedence = new_resource.fp_cert_fetch_autonat_precedence
    cert_revoke_action = new_resource.cert_revoke_action
    version = new_resource.version
    multi_class_list = new_resource.multi_class_list
    session_ticket_lifetime = new_resource.session_ticket_lifetime
    ssli_logging = new_resource.ssli_logging
    session_cache_size = new_resource.session_cache_size
    non_ssl_bypass_service_group = new_resource.non_ssl_bypass_service_group
    forward_proxy_failsafe_disable = new_resource.forward_proxy_failsafe_disable
    session_cache_timeout = new_resource.session_cache_timeout
    sslv2_bypass_service_group = new_resource.sslv2_bypass_service_group
    forward_proxy_decrypted_dscp = new_resource.forward_proxy_decrypted_dscp
    auth_sg = new_resource.auth_sg
    ocspst_ca_cert = new_resource.ocspst_ca_cert
    forward_proxy_selfsign_redir = new_resource.forward_proxy_selfsign_redir
    auth_sg_dn = new_resource.auth_sg_dn
    hsm_type = new_resource.hsm_type
    forward_proxy_log_disable = new_resource.forward_proxy_log_disable
    fp_alt_encrypted = new_resource.fp_alt_encrypted
    cert = new_resource.cert
    web_category = new_resource.web_category
    template_cipher = new_resource.template_cipher
    notbeforemonth = new_resource.notbeforemonth
    chain_cert = new_resource.chain_cert
    forward_proxy_cert_unknown_action = new_resource.forward_proxy_cert_unknown_action
    key = new_resource.key
    ocspst_sg = new_resource.ocspst_sg
    fp_cert_ext_aia_ca_issuers = new_resource.fp_cert_ext_aia_ca_issuers
    authen_name = new_resource.authen_name
    expire_hours = new_resource.expire_hours
    client_auth_case_insensitive = new_resource.client_auth_case_insensitive
    ocsp_stapling = new_resource.ocsp_stapling
    notbeforeyear = new_resource.notbeforeyear
    forward_encrypted = new_resource.forward_encrypted
    sni_enable_log = new_resource.sni_enable_log
    notaftermonth = new_resource.notaftermonth
    cache_persistence_list_name = new_resource.cache_persistence_list_name
    ocspst_sg_timeout = new_resource.ocspst_sg_timeout
    key_passphrase = new_resource.key_passphrase
    ocspst_srvr = new_resource.ocspst_srvr
    ocspst_srvr_minutes = new_resource.ocspst_srvr_minutes
    client_auth_starts_with_list = new_resource.client_auth_starts_with_list
    authorization = new_resource.authorization
    forward_proxy_verify_cert_fail_action = new_resource.forward_proxy_verify_cert_fail_action
    ocspst_srvr_days = new_resource.ocspst_srvr_days
    client_auth_class_list = new_resource.client_auth_class_list
    forward_proxy_decrypted_dscp_bypass = new_resource.forward_proxy_decrypted_dscp_bypass
    alert_type = new_resource.alert_type
    forward_proxy_cert_not_ready_action = new_resource.forward_proxy_cert_not_ready_action
    server_name_list = new_resource.server_name_list
    fp_cert_fetch_natpool_precedence = new_resource.fp_cert_fetch_natpool_precedence
    forward_proxy_cert_cache_limit = new_resource.forward_proxy_cert_cache_limit
    handshake_logging_enable = new_resource.handshake_logging_enable
    client_auth_ends_with_list = new_resource.client_auth_ends_with_list
    close_notify = new_resource.close_notify
    forward_proxy_ocsp_disable = new_resource.forward_proxy_ocsp_disable
    sslilogging = new_resource.sslilogging
    auth_username = new_resource.auth_username
    fp_cert_ext_crldp = new_resource.fp_cert_ext_crldp
    ocspst_sg_days = new_resource.ocspst_sg_days
    inspect_list_name = new_resource.inspect_list_name
    auth_username_attribute = new_resource.auth_username_attribute
    fp_cert_fetch_natpool_name = new_resource.fp_cert_fetch_natpool_name
    ldap_base_dn_from_cert = new_resource.ldap_base_dn_from_cert
    client_certificate = new_resource.client_certificate
    forward_proxy_cert_expiry = new_resource.forward_proxy_cert_expiry
    forward_proxy_enable = new_resource.forward_proxy_enable
    ldap_search_filter = new_resource.ldap_search_filter
    auth_sg_filter = new_resource.auth_sg_filter
    ocspst_srvr_timeout = new_resource.ocspst_srvr_timeout
    enable_tls_alert_logging = new_resource.enable_tls_alert_logging
    exception_class_list = new_resource.exception_class_list
    dh_type = new_resource.dh_type
    fp_alt_cert = new_resource.fp_alt_cert
    case_insensitive = new_resource.case_insensitive
    cipher_without_prio_list = new_resource.cipher_without_prio_list
    ocspst_sg_minutes = new_resource.ocspst_sg_minutes
    starts_with_list = new_resource.starts_with_list

    params = { "client-ssl": {"verify-cert-fail-action": verify_cert_fail_action,
        "forward-proxy-cert-revoke-action": forward_proxy_cert_revoke_action,
        "ocspst-sg-hours": ocspst_sg_hours,
        "fp-cert-fetch-autonat": fp_cert_fetch_autonat,
        "equals-list": equals_list,
        "uuid": uuid,
        "forward-proxy-trusted-ca-lists": forward_proxy_trusted_ca_lists,
        "forward-proxy-ca-cert": forward_proxy_ca_cert,
        "ssl-false-start-disable": ssl_false_start_disable,
        "dgversion": dgversion,
        "ec-list": ec_list,
        "key-encrypted": key_encrypted,
        "notafteryear": notafteryear,
        "forward-proxy-alt-sign": forward_proxy_alt_sign,
        "template-hsm": template_hsm,
        "forward-passphrase": forward_passphrase,
        "contains-list": contains_list,
        "forward-proxy-ca-key": forward_proxy_ca_key,
        "notbefore": notbefore,
        "ends-with-list": ends_with_list,
        "notafter": notafter,
        "class-list-name": class_list_name,
        "ocspst-ocsp": ocspst_ocsp,
        "notbeforeday": notbeforeday,
        "forward-proxy-ssl-version": forward_proxy_ssl_version,
        "ca-certs": ca_certs,
        "forward-proxy-crl-disable": forward_proxy_crl_disable,
        "client-auth-contains-list": client_auth_contains_list,
        "name": a10_name,
        "fp-cert-ext-aia-ocsp": fp_cert_ext_aia_ocsp,
        "req-ca-lists": req_ca_lists,
        "user-tag": user_tag,
        "cert-unknown-action": cert_unknown_action,
        "renegotiation-disable": renegotiation_disable,
        "fp-alt-key": fp_alt_key,
        "server-name-auto-map": server_name_auto_map,
        "disable-sslv3": disable_sslv3,
        "client-auth-equals-list": client_auth_equals_list,
        "fp-alt-passphrase": fp_alt_passphrase,
        "forward-proxy-cert-cache-timeout": forward_proxy_cert_cache_timeout,
        "crl-certs": crl_certs,
        "notafterday": notafterday,
        "ocspst-srvr-hours": ocspst_srvr_hours,
        "local-logging": local_logging,
        "fp-cert-fetch-autonat-precedence": fp_cert_fetch_autonat_precedence,
        "cert-revoke-action": cert_revoke_action,
        "version": version,
        "multi-class-list": multi_class_list,
        "session-ticket-lifetime": session_ticket_lifetime,
        "ssli-logging": ssli_logging,
        "session-cache-size": session_cache_size,
        "non-ssl-bypass-service-group": non_ssl_bypass_service_group,
        "forward-proxy-failsafe-disable": forward_proxy_failsafe_disable,
        "session-cache-timeout": session_cache_timeout,
        "sslv2-bypass-service-group": sslv2_bypass_service_group,
        "forward-proxy-decrypted-dscp": forward_proxy_decrypted_dscp,
        "auth-sg": auth_sg,
        "ocspst-ca-cert": ocspst_ca_cert,
        "forward-proxy-selfsign-redir": forward_proxy_selfsign_redir,
        "auth-sg-dn": auth_sg_dn,
        "hsm-type": hsm_type,
        "forward-proxy-log-disable": forward_proxy_log_disable,
        "fp-alt-encrypted": fp_alt_encrypted,
        "cert": cert,
        "web-category": web_category,
        "template-cipher": template_cipher,
        "notbeforemonth": notbeforemonth,
        "chain-cert": chain_cert,
        "forward-proxy-cert-unknown-action": forward_proxy_cert_unknown_action,
        "key": key,
        "ocspst-sg": ocspst_sg,
        "fp-cert-ext-aia-ca-issuers": fp_cert_ext_aia_ca_issuers,
        "authen-name": authen_name,
        "expire-hours": expire_hours,
        "client-auth-case-insensitive": client_auth_case_insensitive,
        "ocsp-stapling": ocsp_stapling,
        "notbeforeyear": notbeforeyear,
        "forward-encrypted": forward_encrypted,
        "sni-enable-log": sni_enable_log,
        "notaftermonth": notaftermonth,
        "cache-persistence-list-name": cache_persistence_list_name,
        "ocspst-sg-timeout": ocspst_sg_timeout,
        "key-passphrase": key_passphrase,
        "ocspst-srvr": ocspst_srvr,
        "ocspst-srvr-minutes": ocspst_srvr_minutes,
        "client-auth-starts-with-list": client_auth_starts_with_list,
        "authorization": authorization,
        "forward-proxy-verify-cert-fail-action": forward_proxy_verify_cert_fail_action,
        "ocspst-srvr-days": ocspst_srvr_days,
        "client-auth-class-list": client_auth_class_list,
        "forward-proxy-decrypted-dscp-bypass": forward_proxy_decrypted_dscp_bypass,
        "alert-type": alert_type,
        "forward-proxy-cert-not-ready-action": forward_proxy_cert_not_ready_action,
        "server-name-list": server_name_list,
        "fp-cert-fetch-natpool-precedence": fp_cert_fetch_natpool_precedence,
        "forward-proxy-cert-cache-limit": forward_proxy_cert_cache_limit,
        "handshake-logging-enable": handshake_logging_enable,
        "client-auth-ends-with-list": client_auth_ends_with_list,
        "close-notify": close_notify,
        "forward-proxy-ocsp-disable": forward_proxy_ocsp_disable,
        "sslilogging": sslilogging,
        "auth-username": auth_username,
        "fp-cert-ext-crldp": fp_cert_ext_crldp,
        "ocspst-sg-days": ocspst_sg_days,
        "inspect-list-name": inspect_list_name,
        "auth-username-attribute": auth_username_attribute,
        "fp-cert-fetch-natpool-name": fp_cert_fetch_natpool_name,
        "ldap-base-dn-from-cert": ldap_base_dn_from_cert,
        "client-certificate": client_certificate,
        "forward-proxy-cert-expiry": forward_proxy_cert_expiry,
        "forward-proxy-enable": forward_proxy_enable,
        "ldap-search-filter": ldap_search_filter,
        "auth-sg-filter": auth_sg_filter,
        "ocspst-srvr-timeout": ocspst_srvr_timeout,
        "enable-tls-alert-logging": enable_tls_alert_logging,
        "exception-class-list": exception_class_list,
        "dh-type": dh_type,
        "fp-alt-cert": fp_alt_cert,
        "case-insensitive": case_insensitive,
        "cipher-without-prio-list": cipher_without_prio_list,
        "ocspst-sg-minutes": ocspst_sg_minutes,
        "starts-with-list": starts_with_list,} }

    params[:"client-ssl"].each do |k, v|
        if not v
            params[:"client-ssl"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["client-ssl"].each do |k, v|
        if v != params[:"client-ssl"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating client-ssl') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/client-ssl/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting client-ssl') do
            client.delete(url)
        end
    end
end