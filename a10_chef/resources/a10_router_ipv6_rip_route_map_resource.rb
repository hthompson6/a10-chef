resource_name :a10_router_ipv6_rip_route_map

property :a10_name, String, name_property: true
property :map_cfg, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ipv6/rip/"
    get_url = "/axapi/v3/router/ipv6/rip/route-map"
    map_cfg = new_resource.map_cfg
    uuid = new_resource.uuid

    params = { "route-map": {"map-cfg": map_cfg,
        "uuid": uuid,} }

    params[:"route-map"].each do |k, v|
        if not v 
            params[:"route-map"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating route-map') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip/route-map"
    map_cfg = new_resource.map_cfg
    uuid = new_resource.uuid

    params = { "route-map": {"map-cfg": map_cfg,
        "uuid": uuid,} }

    params[:"route-map"].each do |k, v|
        if not v
            params[:"route-map"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["route-map"].each do |k, v|
        if v != params[:"route-map"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating route-map') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip/route-map"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting route-map') do
            client.delete(url)
        end
    end
end