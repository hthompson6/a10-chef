resource_name :a10_router_bgp_network_ip_cidr

property :a10_name, String, name_property: true
property :description, String
property :route_map, String
property :comm_value, String
property :backdoor, [true, false]
property :network_ipv4_cidr, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/network/ip-cidr/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/network/ip-cidr/%<network-ipv4-cidr>s"
    description = new_resource.description
    route_map = new_resource.route_map
    comm_value = new_resource.comm_value
    backdoor = new_resource.backdoor
    network_ipv4_cidr = new_resource.network_ipv4_cidr
    uuid = new_resource.uuid

    params = { "ip-cidr": {"description": description,
        "route-map": route_map,
        "comm-value": comm_value,
        "backdoor": backdoor,
        "network-ipv4-cidr": network_ipv4_cidr,
        "uuid": uuid,} }

    params[:"ip-cidr"].each do |k, v|
        if not v 
            params[:"ip-cidr"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip-cidr') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/network/ip-cidr/%<network-ipv4-cidr>s"
    description = new_resource.description
    route_map = new_resource.route_map
    comm_value = new_resource.comm_value
    backdoor = new_resource.backdoor
    network_ipv4_cidr = new_resource.network_ipv4_cidr
    uuid = new_resource.uuid

    params = { "ip-cidr": {"description": description,
        "route-map": route_map,
        "comm-value": comm_value,
        "backdoor": backdoor,
        "network-ipv4-cidr": network_ipv4_cidr,
        "uuid": uuid,} }

    params[:"ip-cidr"].each do |k, v|
        if not v
            params[:"ip-cidr"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip-cidr"].each do |k, v|
        if v != params[:"ip-cidr"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip-cidr') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/network/ip-cidr/%<network-ipv4-cidr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip-cidr') do
            client.delete(url)
        end
    end
end