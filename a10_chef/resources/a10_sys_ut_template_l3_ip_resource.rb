resource_name :a10_sys_ut_template_l3_ip

property :a10_name, String, name_property: true
property :ipv4_end_address, String
property :ipv6_start_address, String
property :src_dst, ['dest','src'],required: true
property :ve, String
property :nat_pool, String
property :ipv4_start_address, String
property :ipv6_end_address, String
property :virtual_server, String
property :ethernet, String
property :trunk, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/%<name>s/l3/ip/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s/l3/ip/%<src-dst>s"
    ipv4_end_address = new_resource.ipv4_end_address
    ipv6_start_address = new_resource.ipv6_start_address
    src_dst = new_resource.src_dst
    ve = new_resource.ve
    nat_pool = new_resource.nat_pool
    ipv4_start_address = new_resource.ipv4_start_address
    ipv6_end_address = new_resource.ipv6_end_address
    virtual_server = new_resource.virtual_server
    ethernet = new_resource.ethernet
    trunk = new_resource.trunk
    uuid = new_resource.uuid

    params = { "ip": {"ipv4-end-address": ipv4_end_address,
        "ipv6-start-address": ipv6_start_address,
        "src-dst": src_dst,
        "ve": ve,
        "nat-pool": nat_pool,
        "ipv4-start-address": ipv4_start_address,
        "ipv6-end-address": ipv6_end_address,
        "virtual-server": virtual_server,
        "ethernet": ethernet,
        "trunk": trunk,
        "uuid": uuid,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/l3/ip/%<src-dst>s"
    ipv4_end_address = new_resource.ipv4_end_address
    ipv6_start_address = new_resource.ipv6_start_address
    src_dst = new_resource.src_dst
    ve = new_resource.ve
    nat_pool = new_resource.nat_pool
    ipv4_start_address = new_resource.ipv4_start_address
    ipv6_end_address = new_resource.ipv6_end_address
    virtual_server = new_resource.virtual_server
    ethernet = new_resource.ethernet
    trunk = new_resource.trunk
    uuid = new_resource.uuid

    params = { "ip": {"ipv4-end-address": ipv4_end_address,
        "ipv6-start-address": ipv6_start_address,
        "src-dst": src_dst,
        "ve": ve,
        "nat-pool": nat_pool,
        "ipv4-start-address": ipv4_start_address,
        "ipv6-end-address": ipv6_end_address,
        "virtual-server": virtual_server,
        "ethernet": ethernet,
        "trunk": trunk,
        "uuid": uuid,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/l3/ip/%<src-dst>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end