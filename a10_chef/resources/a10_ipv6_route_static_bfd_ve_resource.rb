resource_name :a10_ipv6_route_static_bfd_ve

property :a10_name, String, name_property: true
property :nexthop_ipv6_ll, String,required: true
property :uuid, String
property :ve_num, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/route/static/bfd/ve/"
    get_url = "/axapi/v3/ipv6/route/static/bfd/ve/%<ve-num>s+%<nexthop-ipv6-ll>s"
    nexthop_ipv6_ll = new_resource.nexthop_ipv6_ll
    uuid = new_resource.uuid
    ve_num = new_resource.ve_num

    params = { "ve": {"nexthop-ipv6-ll": nexthop_ipv6_ll,
        "uuid": uuid,
        "ve-num": ve_num,} }

    params[:"ve"].each do |k, v|
        if not v 
            params[:"ve"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ve') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/static/bfd/ve/%<ve-num>s+%<nexthop-ipv6-ll>s"
    nexthop_ipv6_ll = new_resource.nexthop_ipv6_ll
    uuid = new_resource.uuid
    ve_num = new_resource.ve_num

    params = { "ve": {"nexthop-ipv6-ll": nexthop_ipv6_ll,
        "uuid": uuid,
        "ve-num": ve_num,} }

    params[:"ve"].each do |k, v|
        if not v
            params[:"ve"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ve"].each do |k, v|
        if v != params[:"ve"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ve') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/static/bfd/ve/%<ve-num>s+%<nexthop-ipv6-ll>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ve') do
            client.delete(url)
        end
    end
end