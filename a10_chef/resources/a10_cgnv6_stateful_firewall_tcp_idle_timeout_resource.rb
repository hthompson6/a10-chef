resource_name :a10_cgnv6_stateful_firewall_tcp_idle_timeout

property :a10_name, String, name_property: true
property :port, Integer,required: true
property :port_end, Integer,required: true
property :idle_timeout_val_port_range, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/stateful-firewall/tcp/idle-timeout/"
    get_url = "/axapi/v3/cgnv6/stateful-firewall/tcp/idle-timeout/%<port>s+%<port-end>s"
    port = new_resource.port
    port_end = new_resource.port_end
    idle_timeout_val_port_range = new_resource.idle_timeout_val_port_range
    uuid = new_resource.uuid

    params = { "idle-timeout": {"port": port,
        "port-end": port_end,
        "idle-timeout-val-port-range": idle_timeout_val_port_range,
        "uuid": uuid,} }

    params[:"idle-timeout"].each do |k, v|
        if not v 
            params[:"idle-timeout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating idle-timeout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/tcp/idle-timeout/%<port>s+%<port-end>s"
    port = new_resource.port
    port_end = new_resource.port_end
    idle_timeout_val_port_range = new_resource.idle_timeout_val_port_range
    uuid = new_resource.uuid

    params = { "idle-timeout": {"port": port,
        "port-end": port_end,
        "idle-timeout-val-port-range": idle_timeout_val_port_range,
        "uuid": uuid,} }

    params[:"idle-timeout"].each do |k, v|
        if not v
            params[:"idle-timeout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["idle-timeout"].each do |k, v|
        if v != params[:"idle-timeout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating idle-timeout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/tcp/idle-timeout/%<port>s+%<port-end>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting idle-timeout') do
            client.delete(url)
        end
    end
end