resource_name :a10_cgnv6_server

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :port_list, Array
property :fqdn_name, String
property :host, String
property :user_tag, String
property :sampling_enable, Array
property :a10_action, ['enable','disable']
property :server_ipv6_addr, String
property :health_check, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/server/"
    get_url = "/axapi/v3/cgnv6/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    a10_name = new_resource.a10_name
    fqdn_name = new_resource.fqdn_name
    host = new_resource.host
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    server_ipv6_addr = new_resource.server_ipv6_addr
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "server": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "name": a10_name,
        "fqdn-name": fqdn_name,
        "host": host,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "server-ipv6-addr": server_ipv6_addr,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"server"].each do |k, v|
        if not v 
            params[:"server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    a10_name = new_resource.a10_name
    fqdn_name = new_resource.fqdn_name
    host = new_resource.host
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    server_ipv6_addr = new_resource.server_ipv6_addr
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "server": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "name": a10_name,
        "fqdn-name": fqdn_name,
        "host": host,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "server-ipv6-addr": server_ipv6_addr,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"server"].each do |k, v|
        if not v
            params[:"server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["server"].each do |k, v|
        if v != params[:"server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/server/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server') do
            client.delete(url)
        end
    end
end