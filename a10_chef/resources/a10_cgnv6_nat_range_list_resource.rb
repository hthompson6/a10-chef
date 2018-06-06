resource_name :a10_cgnv6_nat_range_list

property :a10_name, String, name_property: true
property :v4_vrid, Integer
property :uuid, String
property :partition, String,required: true
property :local_netmaskv4, String
property :local_start_ipv4_addr, String
property :global_start_ipv4_addr, String
property :v4_count, Integer
property :global_netmaskv4, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat/range-list/"
    get_url = "/axapi/v3/cgnv6/nat/range-list/%<name>s+%<partition>s"
    v4_vrid = new_resource.v4_vrid
    uuid = new_resource.uuid
    partition = new_resource.partition
    a10_name = new_resource.a10_name
    local_netmaskv4 = new_resource.local_netmaskv4
    local_start_ipv4_addr = new_resource.local_start_ipv4_addr
    global_start_ipv4_addr = new_resource.global_start_ipv4_addr
    v4_count = new_resource.v4_count
    global_netmaskv4 = new_resource.global_netmaskv4

    params = { "range-list": {"v4-vrid": v4_vrid,
        "uuid": uuid,
        "partition": partition,
        "name": a10_name,
        "local-netmaskv4": local_netmaskv4,
        "local-start-ipv4-addr": local_start_ipv4_addr,
        "global-start-ipv4-addr": global_start_ipv4_addr,
        "v4-count": v4_count,
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
    url = "/axapi/v3/cgnv6/nat/range-list/%<name>s+%<partition>s"
    v4_vrid = new_resource.v4_vrid
    uuid = new_resource.uuid
    partition = new_resource.partition
    a10_name = new_resource.a10_name
    local_netmaskv4 = new_resource.local_netmaskv4
    local_start_ipv4_addr = new_resource.local_start_ipv4_addr
    global_start_ipv4_addr = new_resource.global_start_ipv4_addr
    v4_count = new_resource.v4_count
    global_netmaskv4 = new_resource.global_netmaskv4

    params = { "range-list": {"v4-vrid": v4_vrid,
        "uuid": uuid,
        "partition": partition,
        "name": a10_name,
        "local-netmaskv4": local_netmaskv4,
        "local-start-ipv4-addr": local_start_ipv4_addr,
        "global-start-ipv4-addr": global_start_ipv4_addr,
        "v4-count": v4_count,
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
    url = "/axapi/v3/cgnv6/nat/range-list/%<name>s+%<partition>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting range-list') do
            client.delete(url)
        end
    end
end