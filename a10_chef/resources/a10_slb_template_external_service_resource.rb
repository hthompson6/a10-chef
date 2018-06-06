resource_name :a10_slb_template_external_service

property :a10_name, String, name_property: true
property :source_ip, String
property :request_header_forward_list, Array
property :bypass_ip_cfg, Array
property :user_tag, String
property :service_group, String
property :failure_action, ['continue','drop','reset']
property :timeout, Integer
property :tcp_proxy, String
property :a10_action, ['continue','drop','reset']
property :ntype, ['skyfire-icap','url-filter']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/external-service/"
    get_url = "/axapi/v3/slb/template/external-service/%<name>s"
    a10_name = new_resource.a10_name
    source_ip = new_resource.source_ip
    request_header_forward_list = new_resource.request_header_forward_list
    bypass_ip_cfg = new_resource.bypass_ip_cfg
    user_tag = new_resource.user_tag
    service_group = new_resource.service_group
    failure_action = new_resource.failure_action
    timeout = new_resource.timeout
    tcp_proxy = new_resource.tcp_proxy
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype
    uuid = new_resource.uuid

    params = { "external-service": {"name": a10_name,
        "source-ip": source_ip,
        "request-header-forward-list": request_header_forward_list,
        "bypass-ip-cfg": bypass_ip_cfg,
        "user-tag": user_tag,
        "service-group": service_group,
        "failure-action": failure_action,
        "timeout": timeout,
        "tcp-proxy": tcp_proxy,
        "action": a10_action,
        "type": ntype,
        "uuid": uuid,} }

    params[:"external-service"].each do |k, v|
        if not v 
            params[:"external-service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating external-service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/external-service/%<name>s"
    a10_name = new_resource.a10_name
    source_ip = new_resource.source_ip
    request_header_forward_list = new_resource.request_header_forward_list
    bypass_ip_cfg = new_resource.bypass_ip_cfg
    user_tag = new_resource.user_tag
    service_group = new_resource.service_group
    failure_action = new_resource.failure_action
    timeout = new_resource.timeout
    tcp_proxy = new_resource.tcp_proxy
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype
    uuid = new_resource.uuid

    params = { "external-service": {"name": a10_name,
        "source-ip": source_ip,
        "request-header-forward-list": request_header_forward_list,
        "bypass-ip-cfg": bypass_ip_cfg,
        "user-tag": user_tag,
        "service-group": service_group,
        "failure-action": failure_action,
        "timeout": timeout,
        "tcp-proxy": tcp_proxy,
        "action": a10_action,
        "type": ntype,
        "uuid": uuid,} }

    params[:"external-service"].each do |k, v|
        if not v
            params[:"external-service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["external-service"].each do |k, v|
        if v != params[:"external-service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating external-service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/external-service/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting external-service') do
            client.delete(url)
        end
    end
end