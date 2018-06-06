resource_name :a10_cgnv6_stateful_firewall_udp_stun_timeout

property :a10_name, String, name_property: true
property :port_end, Integer,required: true
property :stun_timeout_val_port_range, Integer
property :uuid, String
property :port, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/stateful-firewall/udp/stun-timeout/"
    get_url = "/axapi/v3/cgnv6/stateful-firewall/udp/stun-timeout/%<port>s+%<port-end>s"
    port_end = new_resource.port_end
    stun_timeout_val_port_range = new_resource.stun_timeout_val_port_range
    uuid = new_resource.uuid
    port = new_resource.port

    params = { "stun-timeout": {"port-end": port_end,
        "stun-timeout-val-port-range": stun_timeout_val_port_range,
        "uuid": uuid,
        "port": port,} }

    params[:"stun-timeout"].each do |k, v|
        if not v 
            params[:"stun-timeout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating stun-timeout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/udp/stun-timeout/%<port>s+%<port-end>s"
    port_end = new_resource.port_end
    stun_timeout_val_port_range = new_resource.stun_timeout_val_port_range
    uuid = new_resource.uuid
    port = new_resource.port

    params = { "stun-timeout": {"port-end": port_end,
        "stun-timeout-val-port-range": stun_timeout_val_port_range,
        "uuid": uuid,
        "port": port,} }

    params[:"stun-timeout"].each do |k, v|
        if not v
            params[:"stun-timeout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["stun-timeout"].each do |k, v|
        if v != params[:"stun-timeout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating stun-timeout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/udp/stun-timeout/%<port>s+%<port-end>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting stun-timeout') do
            client.delete(url)
        end
    end
end