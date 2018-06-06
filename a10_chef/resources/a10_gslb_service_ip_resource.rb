resource_name :a10_gslb_service_ip

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :port_list, Array
property :uuid, String
property :external_ip, String
property :node_name, String,required: true
property :sampling_enable, Array
property :a10_action, ['enable','disable']
property :user_tag, String
property :ip_address, String
property :ipv6, String
property :ipv6_address, String
property :health_check_protocol_disable, [true, false]
property :health_check, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/service-ip/"
    get_url = "/axapi/v3/gslb/service-ip/%<node-name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    uuid = new_resource.uuid
    external_ip = new_resource.external_ip
    node_name = new_resource.node_name
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    ip_address = new_resource.ip_address
    ipv6 = new_resource.ipv6
    ipv6_address = new_resource.ipv6_address
    health_check_protocol_disable = new_resource.health_check_protocol_disable
    health_check = new_resource.health_check

    params = { "service-ip": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "uuid": uuid,
        "external-ip": external_ip,
        "node-name": node_name,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "user-tag": user_tag,
        "ip-address": ip_address,
        "ipv6": ipv6,
        "ipv6-address": ipv6_address,
        "health-check-protocol-disable": health_check_protocol_disable,
        "health-check": health_check,} }

    params[:"service-ip"].each do |k, v|
        if not v 
            params[:"service-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/service-ip/%<node-name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    uuid = new_resource.uuid
    external_ip = new_resource.external_ip
    node_name = new_resource.node_name
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    ip_address = new_resource.ip_address
    ipv6 = new_resource.ipv6
    ipv6_address = new_resource.ipv6_address
    health_check_protocol_disable = new_resource.health_check_protocol_disable
    health_check = new_resource.health_check

    params = { "service-ip": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "uuid": uuid,
        "external-ip": external_ip,
        "node-name": node_name,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "user-tag": user_tag,
        "ip-address": ip_address,
        "ipv6": ipv6,
        "ipv6-address": ipv6_address,
        "health-check-protocol-disable": health_check_protocol_disable,
        "health-check": health_check,} }

    params[:"service-ip"].each do |k, v|
        if not v
            params[:"service-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-ip"].each do |k, v|
        if v != params[:"service-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/service-ip/%<node-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-ip') do
            client.delete(url)
        end
    end
end