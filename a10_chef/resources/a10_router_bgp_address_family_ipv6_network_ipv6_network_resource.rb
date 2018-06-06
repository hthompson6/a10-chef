resource_name :a10_router_bgp_address_family_ipv6_network_ipv6_network

property :a10_name, String, name_property: true
property :description, String
property :route_map, String
property :comm_value, String
property :network_ipv6, String,required: true
property :backdoor, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/ipv6-network/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/ipv6-network/%<network-ipv6>s"
    description = new_resource.description
    route_map = new_resource.route_map
    comm_value = new_resource.comm_value
    network_ipv6 = new_resource.network_ipv6
    backdoor = new_resource.backdoor
    uuid = new_resource.uuid

    params = { "ipv6-network": {"description": description,
        "route-map": route_map,
        "comm-value": comm_value,
        "network-ipv6": network_ipv6,
        "backdoor": backdoor,
        "uuid": uuid,} }

    params[:"ipv6-network"].each do |k, v|
        if not v 
            params[:"ipv6-network"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6-network') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/ipv6-network/%<network-ipv6>s"
    description = new_resource.description
    route_map = new_resource.route_map
    comm_value = new_resource.comm_value
    network_ipv6 = new_resource.network_ipv6
    backdoor = new_resource.backdoor
    uuid = new_resource.uuid

    params = { "ipv6-network": {"description": description,
        "route-map": route_map,
        "comm-value": comm_value,
        "network-ipv6": network_ipv6,
        "backdoor": backdoor,
        "uuid": uuid,} }

    params[:"ipv6-network"].each do |k, v|
        if not v
            params[:"ipv6-network"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6-network"].each do |k, v|
        if v != params[:"ipv6-network"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6-network') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/ipv6-network/%<network-ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6-network') do
            client.delete(url)
        end
    end
end