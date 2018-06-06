resource_name :a10_ipv6_ospf

property :a10_name, String, name_property: true
property :display_route_single_line, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/"
    get_url = "/axapi/v3/ipv6/ospf"
    display_route_single_line = new_resource.display_route_single_line
    uuid = new_resource.uuid

    params = { "ospf": {"display-route-single-line": display_route_single_line,
        "uuid": uuid,} }

    params[:"ospf"].each do |k, v|
        if not v 
            params[:"ospf"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/ospf"
    display_route_single_line = new_resource.display_route_single_line
    uuid = new_resource.uuid

    params = { "ospf": {"display-route-single-line": display_route_single_line,
        "uuid": uuid,} }

    params[:"ospf"].each do |k, v|
        if not v
            params[:"ospf"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf"].each do |k, v|
        if v != params[:"ospf"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/ospf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end