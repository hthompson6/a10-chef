resource_name :a10_ip_route_rib

property :a10_name, String, name_property: true
property :ip_nexthop_lif, Array
property :ip_nexthop_ipv4, Array
property :uuid, String
property :ip_dest_addr, String,required: true
property :ip_nexthop_tunnel, Array
property :ip_nexthop_partition, Array
property :ip_mask, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/route/rib/"
    get_url = "/axapi/v3/ip/route/rib/%<ip-dest-addr>s+%<ip-mask>s"
    ip_nexthop_lif = new_resource.ip_nexthop_lif
    ip_nexthop_ipv4 = new_resource.ip_nexthop_ipv4
    uuid = new_resource.uuid
    ip_dest_addr = new_resource.ip_dest_addr
    ip_nexthop_tunnel = new_resource.ip_nexthop_tunnel
    ip_nexthop_partition = new_resource.ip_nexthop_partition
    ip_mask = new_resource.ip_mask

    params = { "rib": {"ip-nexthop-lif": ip_nexthop_lif,
        "ip-nexthop-ipv4": ip_nexthop_ipv4,
        "uuid": uuid,
        "ip-dest-addr": ip_dest_addr,
        "ip-nexthop-tunnel": ip_nexthop_tunnel,
        "ip-nexthop-partition": ip_nexthop_partition,
        "ip-mask": ip_mask,} }

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
    url = "/axapi/v3/ip/route/rib/%<ip-dest-addr>s+%<ip-mask>s"
    ip_nexthop_lif = new_resource.ip_nexthop_lif
    ip_nexthop_ipv4 = new_resource.ip_nexthop_ipv4
    uuid = new_resource.uuid
    ip_dest_addr = new_resource.ip_dest_addr
    ip_nexthop_tunnel = new_resource.ip_nexthop_tunnel
    ip_nexthop_partition = new_resource.ip_nexthop_partition
    ip_mask = new_resource.ip_mask

    params = { "rib": {"ip-nexthop-lif": ip_nexthop_lif,
        "ip-nexthop-ipv4": ip_nexthop_ipv4,
        "uuid": uuid,
        "ip-dest-addr": ip_dest_addr,
        "ip-nexthop-tunnel": ip_nexthop_tunnel,
        "ip-nexthop-partition": ip_nexthop_partition,
        "ip-mask": ip_mask,} }

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
    url = "/axapi/v3/ip/route/rib/%<ip-dest-addr>s+%<ip-mask>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rib') do
            client.delete(url)
        end
    end
end