resource_name :a10_cgnv6_lw_4o6_binding_table_tunnel_address_nat_address_port_range

property :a10_name, String, name_property: true
property :port_start, Integer,required: true
property :tunnel_endpoint_address, String
property :port_end, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s/port-range/"
    get_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s/port-range/%<port-start>s+%<port-end>s"
    port_start = new_resource.port_start
    tunnel_endpoint_address = new_resource.tunnel_endpoint_address
    port_end = new_resource.port_end

    params = { "port-range": {"port-start": port_start,
        "tunnel-endpoint-address": tunnel_endpoint_address,
        "port-end": port_end,} }

    params[:"port-range"].each do |k, v|
        if not v 
            params[:"port-range"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port-range') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s/port-range/%<port-start>s+%<port-end>s"
    port_start = new_resource.port_start
    tunnel_endpoint_address = new_resource.tunnel_endpoint_address
    port_end = new_resource.port_end

    params = { "port-range": {"port-start": port_start,
        "tunnel-endpoint-address": tunnel_endpoint_address,
        "port-end": port_end,} }

    params[:"port-range"].each do |k, v|
        if not v
            params[:"port-range"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port-range"].each do |k, v|
        if v != params[:"port-range"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port-range') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s/port-range/%<port-start>s+%<port-end>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port-range') do
            client.delete(url)
        end
    end
end