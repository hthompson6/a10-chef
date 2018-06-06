resource_name :a10_interface_ve_ipv6_router_ospf

property :a10_name, String, name_property: true
property :area_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/router/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/router/ospf"
    area_list = new_resource.area_list
    uuid = new_resource.uuid

    params = { "ospf": {"area-list": area_list,
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
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/router/ospf"
    area_list = new_resource.area_list
    uuid = new_resource.uuid

    params = { "ospf": {"area-list": area_list,
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
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/router/ospf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end