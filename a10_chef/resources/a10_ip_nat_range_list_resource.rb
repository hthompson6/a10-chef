resource_name :a10_ip_nat_range_list

property :a10_name, String, name_property: true
property :global_start_ipv6_addr, String
property :v4_vrid, Integer
property :uuid, String
property :v4_count, Integer
property :local_start_ipv6_addr, String
property :global_start_ipv4_addr, String
property :local_netmaskv4, String
property :local_start_ipv4_addr, String
property :v4_acl_name, String
property :v6_vrid, Integer
property :v6_acl_name, String
property :v4_acl_id, Integer
property :v6_count, Integer
property :global_netmaskv4, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/range-list/"
    get_url = "/axapi/v3/ip/nat/range-list/%<name>s"
    global_start_ipv6_addr = new_resource.global_start_ipv6_addr
    v4_vrid = new_resource.v4_vrid
    uuid = new_resource.uuid
    v4_count = new_resource.v4_count
    local_start_ipv6_addr = new_resource.local_start_ipv6_addr
    a10_name = new_resource.a10_name
    global_start_ipv4_addr = new_resource.global_start_ipv4_addr
    local_netmaskv4 = new_resource.local_netmaskv4
    local_start_ipv4_addr = new_resource.local_start_ipv4_addr
    v4_acl_name = new_resource.v4_acl_name
    v6_vrid = new_resource.v6_vrid
    v6_acl_name = new_resource.v6_acl_name
    v4_acl_id = new_resource.v4_acl_id
    v6_count = new_resource.v6_count
    global_netmaskv4 = new_resource.global_netmaskv4

    params = { "range-list": {"global-start-ipv6-addr": global_start_ipv6_addr,
        "v4-vrid": v4_vrid,
        "uuid": uuid,
        "v4-count": v4_count,
        "local-start-ipv6-addr": local_start_ipv6_addr,
        "name": a10_name,
        "global-start-ipv4-addr": global_start_ipv4_addr,
        "local-netmaskv4": local_netmaskv4,
        "local-start-ipv4-addr": local_start_ipv4_addr,
        "v4-acl-name": v4_acl_name,
        "v6-vrid": v6_vrid,
        "v6-acl-name": v6_acl_name,
        "v4-acl-id": v4_acl_id,
        "v6-count": v6_count,
        "global-netmaskv4": global_netmaskv4,} }

    params[:"range-list"].each do |k, v|
        if not v 
            params[:"range-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating range-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/range-list/%<name>s"
    global_start_ipv6_addr = new_resource.global_start_ipv6_addr
    v4_vrid = new_resource.v4_vrid
    uuid = new_resource.uuid
    v4_count = new_resource.v4_count
    local_start_ipv6_addr = new_resource.local_start_ipv6_addr
    a10_name = new_resource.a10_name
    global_start_ipv4_addr = new_resource.global_start_ipv4_addr
    local_netmaskv4 = new_resource.local_netmaskv4
    local_start_ipv4_addr = new_resource.local_start_ipv4_addr
    v4_acl_name = new_resource.v4_acl_name
    v6_vrid = new_resource.v6_vrid
    v6_acl_name = new_resource.v6_acl_name
    v4_acl_id = new_resource.v4_acl_id
    v6_count = new_resource.v6_count
    global_netmaskv4 = new_resource.global_netmaskv4

    params = { "range-list": {"global-start-ipv6-addr": global_start_ipv6_addr,
        "v4-vrid": v4_vrid,
        "uuid": uuid,
        "v4-count": v4_count,
        "local-start-ipv6-addr": local_start_ipv6_addr,
        "name": a10_name,
        "global-start-ipv4-addr": global_start_ipv4_addr,
        "local-netmaskv4": local_netmaskv4,
        "local-start-ipv4-addr": local_start_ipv4_addr,
        "v4-acl-name": v4_acl_name,
        "v6-vrid": v6_vrid,
        "v6-acl-name": v6_acl_name,
        "v4-acl-id": v4_acl_id,
        "v6-count": v6_count,
        "global-netmaskv4": global_netmaskv4,} }

    params[:"range-list"].each do |k, v|
        if not v
            params[:"range-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["range-list"].each do |k, v|
        if v != params[:"range-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating range-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/range-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting range-list') do
            client.delete(url)
        end
    end
end