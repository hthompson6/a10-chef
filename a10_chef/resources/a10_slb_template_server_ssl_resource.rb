resource_name :a10_slb_template_server_ssl

property :a10_name, String, name_property: true
property :session_cache_timeout, Integer
property :cipher_template, String
property :sslilogging, ['disable','all']
property :user_tag, String
property :passphrase, String
property :ocsp_stapling, [true, false]
property :crl_certs, Array
property :uuid, String
property :dgversion, Integer
property :version, Integer
property :ec_list, Array
property :encrypted, String
property :ssli_logging, [true, false]
property :session_cache_size, Integer
property :dh_type, ['1024','1024-dsa','2048']
property :use_client_sni, [true, false]
property :forward_proxy_enable, [true, false]
property :key, String
property :cipher_without_prio_list, Array
property :ca_certs, Array
property :enable_tls_alert_logging, [true, false]
property :session_ticket_enable, [true, false]
property :alert_type, ['fatal']
property :cert, String
property :handshake_logging_enable, [true, false]
property :renegotiation_disable, [true, false]
property :server_certificate_error, Array
property :close_notify, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/server-ssl/"
    get_url = "/axapi/v3/slb/template/server-ssl/%<name>s"
    session_cache_timeout = new_resource.session_cache_timeout
    cipher_template = new_resource.cipher_template
    sslilogging = new_resource.sslilogging
    user_tag = new_resource.user_tag
    passphrase = new_resource.passphrase
    ocsp_stapling = new_resource.ocsp_stapling
    crl_certs = new_resource.crl_certs
    uuid = new_resource.uuid
    dgversion = new_resource.dgversion
    version = new_resource.version
    ec_list = new_resource.ec_list
    encrypted = new_resource.encrypted
    ssli_logging = new_resource.ssli_logging
    session_cache_size = new_resource.session_cache_size
    dh_type = new_resource.dh_type
    use_client_sni = new_resource.use_client_sni
    forward_proxy_enable = new_resource.forward_proxy_enable
    key = new_resource.key
    cipher_without_prio_list = new_resource.cipher_without_prio_list
    ca_certs = new_resource.ca_certs
    a10_name = new_resource.a10_name
    enable_tls_alert_logging = new_resource.enable_tls_alert_logging
    session_ticket_enable = new_resource.session_ticket_enable
    alert_type = new_resource.alert_type
    cert = new_resource.cert
    handshake_logging_enable = new_resource.handshake_logging_enable
    renegotiation_disable = new_resource.renegotiation_disable
    server_certificate_error = new_resource.server_certificate_error
    close_notify = new_resource.close_notify

    params = { "server-ssl": {"session-cache-timeout": session_cache_timeout,
        "cipher-template": cipher_template,
        "sslilogging": sslilogging,
        "user-tag": user_tag,
        "passphrase": passphrase,
        "ocsp-stapling": ocsp_stapling,
        "crl-certs": crl_certs,
        "uuid": uuid,
        "dgversion": dgversion,
        "version": version,
        "ec-list": ec_list,
        "encrypted": encrypted,
        "ssli-logging": ssli_logging,
        "session-cache-size": session_cache_size,
        "dh-type": dh_type,
        "use-client-sni": use_client_sni,
        "forward-proxy-enable": forward_proxy_enable,
        "key": key,
        "cipher-without-prio-list": cipher_without_prio_list,
        "ca-certs": ca_certs,
        "name": a10_name,
        "enable-tls-alert-logging": enable_tls_alert_logging,
        "session-ticket-enable": session_ticket_enable,
        "alert-type": alert_type,
        "cert": cert,
        "handshake-logging-enable": handshake_logging_enable,
        "renegotiation-disable": renegotiation_disable,
        "server-certificate-error": server_certificate_error,
        "close-notify": close_notify,} }

    params[:"server-ssl"].each do |k, v|
        if not v 
            params[:"server-ssl"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating server-ssl') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/server-ssl/%<name>s"
    session_cache_timeout = new_resource.session_cache_timeout
    cipher_template = new_resource.cipher_template
    sslilogging = new_resource.sslilogging
    user_tag = new_resource.user_tag
    passphrase = new_resource.passphrase
    ocsp_stapling = new_resource.ocsp_stapling
    crl_certs = new_resource.crl_certs
    uuid = new_resource.uuid
    dgversion = new_resource.dgversion
    version = new_resource.version
    ec_list = new_resource.ec_list
    encrypted = new_resource.encrypted
    ssli_logging = new_resource.ssli_logging
    session_cache_size = new_resource.session_cache_size
    dh_type = new_resource.dh_type
    use_client_sni = new_resource.use_client_sni
    forward_proxy_enable = new_resource.forward_proxy_enable
    key = new_resource.key
    cipher_without_prio_list = new_resource.cipher_without_prio_list
    ca_certs = new_resource.ca_certs
    a10_name = new_resource.a10_name
    enable_tls_alert_logging = new_resource.enable_tls_alert_logging
    session_ticket_enable = new_resource.session_ticket_enable
    alert_type = new_resource.alert_type
    cert = new_resource.cert
    handshake_logging_enable = new_resource.handshake_logging_enable
    renegotiation_disable = new_resource.renegotiation_disable
    server_certificate_error = new_resource.server_certificate_error
    close_notify = new_resource.close_notify

    params = { "server-ssl": {"session-cache-timeout": session_cache_timeout,
        "cipher-template": cipher_template,
        "sslilogging": sslilogging,
        "user-tag": user_tag,
        "passphrase": passphrase,
        "ocsp-stapling": ocsp_stapling,
        "crl-certs": crl_certs,
        "uuid": uuid,
        "dgversion": dgversion,
        "version": version,
        "ec-list": ec_list,
        "encrypted": encrypted,
        "ssli-logging": ssli_logging,
        "session-cache-size": session_cache_size,
        "dh-type": dh_type,
        "use-client-sni": use_client_sni,
        "forward-proxy-enable": forward_proxy_enable,
        "key": key,
        "cipher-without-prio-list": cipher_without_prio_list,
        "ca-certs": ca_certs,
        "name": a10_name,
        "enable-tls-alert-logging": enable_tls_alert_logging,
        "session-ticket-enable": session_ticket_enable,
        "alert-type": alert_type,
        "cert": cert,
        "handshake-logging-enable": handshake_logging_enable,
        "renegotiation-disable": renegotiation_disable,
        "server-certificate-error": server_certificate_error,
        "close-notify": close_notify,} }

    params[:"server-ssl"].each do |k, v|
        if not v
            params[:"server-ssl"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["server-ssl"].each do |k, v|
        if v != params[:"server-ssl"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating server-ssl') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/server-ssl/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server-ssl') do
            client.delete(url)
        end
    end
end