resource_name :a10_ipv6_route_rib

property :a10_name, String, name_property: true
property :ipv6_address, String,required: true
property :ipv6_nexthop_tunnel, Array
property :uuid, String
property :ipv6_nexthop_ipv6, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/route/rib/"
    get_url = "/axapi/v3/ipv6/route/rib/%<ipv6-address>s"
    ipv6_address = new_resource.ipv6_address
    ipv6_nexthop_tunnel = new_resource.ipv6_nexthop_tunnel
    uuid = new_resource.uuid
    ipv6_nexthop_ipv6 = new_resource.ipv6_nexthop_ipv6

    params = { "rib": {"ipv6-address": ipv6_address,
        "ipv6-nexthop-tunnel": ipv6_nexthop_tunnel,
        "uuid": uuid,
        "ipv6-nexthop-ipv6": ipv6_nexthop_ipv6,} }

    params[:"rib"].each do |k, v|
        if not v 
            params[:"rib"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rib') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/rib/%<ipv6-address>s"
    ipv6_address = new_resource.ipv6_address
    ipv6_nexthop_tunnel = new_resource.ipv6_nexthop_tunnel
    uuid = new_resource.uuid
    ipv6_nexthop_ipv6 = new_resource.ipv6_nexthop_ipv6

    params = { "rib": {"ipv6-address": ipv6_address,
        "ipv6-nexthop-tunnel": ipv6_nexthop_tunnel,
        "uuid": uuid,
        "ipv6-nexthop-ipv6": ipv6_nexthop_ipv6,} }

    params[:"rib"].each do |k, v|
        if not v
            params[:"rib"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rib"].each do |k, v|
        if v != params[:"rib"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rib') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/route/rib/%<ipv6-address>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rib') do
            client.delete(url)
        end
    end
end