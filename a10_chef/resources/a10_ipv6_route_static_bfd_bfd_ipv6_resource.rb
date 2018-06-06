resource_name :a10_ipv6_route_static_bfd_bfd_ipv6

property :a10_name, String, name_property: true
property :local_ipv6, String,required: true
property :uuid, String
property :nexthop_ipv6, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/route/static/bfd/bfd-ipv6/"
    get_url = "/axapi/v3/ipv6/route/static/bfd/bfd-ipv6/%<local-ipv6>s+%<nexthop-ipv6>s"
    local_ipv6 = new_resource.local_ipv6
    uuid = new_resource.uuid
    nexthop_ipv6 = new_resource.nexthop_ipv6

    params = { "bfd-ipv6": {"local-ipv6": local_ipv6,
        "uuid": uuid,
        "nexthop-ipv6": nexthop_ipv6,} }

    params[:"bfd-ipv6"].each do |k, v|
        if not v 
            params[:"bfd-ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bfd-ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/static/bfd/bfd-ipv6/%<local-ipv6>s+%<nexthop-ipv6>s"
    local_ipv6 = new_resource.local_ipv6
    uuid = new_resource.uuid
    nexthop_ipv6 = new_resource.nexthop_ipv6

    params = { "bfd-ipv6": {"local-ipv6": local_ipv6,
        "uuid": uuid,
        "nexthop-ipv6": nexthop_ipv6,} }

    params[:"bfd-ipv6"].each do |k, v|
        if not v
            params[:"bfd-ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bfd-ipv6"].each do |k, v|
        if v != params[:"bfd-ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bfd-ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/static/bfd/bfd-ipv6/%<local-ipv6>s+%<nexthop-ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bfd-ipv6') do
            client.delete(url)
        end
    end
end