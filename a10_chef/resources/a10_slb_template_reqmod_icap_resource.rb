resource_name :a10_slb_template_reqmod_icap

property :a10_name, String, name_property: true
property :min_payload_size, Integer
property :logging, String
property :uuid, String
property :server_ssl, String
property :service_url, String
property :bypass_ip_cfg, Array
property :user_tag, String
property :fail_close, [true, false]
property :service_group, String
property :allowed_http_methods, String
property :tcp_proxy, String
property :a10_action, ['continue','drop','reset']
property :include_protocol_in_uri, [true, false]
property :preview, Integer
property :source_ip, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/reqmod-icap/"
    get_url = "/axapi/v3/slb/template/reqmod-icap/%<name>s"
    min_payload_size = new_resource.min_payload_size
    logging = new_resource.logging
    uuid = new_resource.uuid
    server_ssl = new_resource.server_ssl
    service_url = new_resource.service_url
    bypass_ip_cfg = new_resource.bypass_ip_cfg
    user_tag = new_resource.user_tag
    fail_close = new_resource.fail_close
    service_group = new_resource.service_group
    allowed_http_methods = new_resource.allowed_http_methods
    tcp_proxy = new_resource.tcp_proxy
    a10_name = new_resource.a10_name
    include_protocol_in_uri = new_resource.include_protocol_in_uri
    preview = new_resource.preview
    source_ip = new_resource.source_ip
    a10_name = new_resource.a10_name

    params = { "reqmod-icap": {"min-payload-size": min_payload_size,
        "logging": logging,
        "uuid": uuid,
        "server-ssl": server_ssl,
        "service-url": service_url,
        "bypass-ip-cfg": bypass_ip_cfg,
        "user-tag": user_tag,
        "fail-close": fail_close,
        "service-group": service_group,
        "allowed-http-methods": allowed_http_methods,
        "tcp-proxy": tcp_proxy,
        "action": a10_action,
        "include-protocol-in-uri": include_protocol_in_uri,
        "preview": preview,
        "source-ip": source_ip,
        "name": a10_name,} }

    params[:"reqmod-icap"].each do |k, v|
        if not v 
            params[:"reqmod-icap"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reqmod-icap') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/reqmod-icap/%<name>s"
    min_payload_size = new_resource.min_payload_size
    logging = new_resource.logging
    uuid = new_resource.uuid
    server_ssl = new_resource.server_ssl
    service_url = new_resource.service_url
    bypass_ip_cfg = new_resource.bypass_ip_cfg
    user_tag = new_resource.user_tag
    fail_close = new_resource.fail_close
    service_group = new_resource.service_group
    allowed_http_methods = new_resource.allowed_http_methods
    tcp_proxy = new_resource.tcp_proxy
    a10_name = new_resource.a10_name
    include_protocol_in_uri = new_resource.include_protocol_in_uri
    preview = new_resource.preview
    source_ip = new_resource.source_ip
    a10_name = new_resource.a10_name

    params = { "reqmod-icap": {"min-payload-size": min_payload_size,
        "logging": logging,
        "uuid": uuid,
        "server-ssl": server_ssl,
        "service-url": service_url,
        "bypass-ip-cfg": bypass_ip_cfg,
        "user-tag": user_tag,
        "fail-close": fail_close,
        "service-group": service_group,
        "allowed-http-methods": allowed_http_methods,
        "tcp-proxy": tcp_proxy,
        "action": a10_action,
        "include-protocol-in-uri": include_protocol_in_uri,
        "preview": preview,
        "source-ip": source_ip,
        "name": a10_name,} }

    params[:"reqmod-icap"].each do |k, v|
        if not v
            params[:"reqmod-icap"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reqmod-icap"].each do |k, v|
        if v != params[:"reqmod-icap"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reqmod-icap') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/reqmod-icap/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reqmod-icap') do
            client.delete(url)
        end
    end
end