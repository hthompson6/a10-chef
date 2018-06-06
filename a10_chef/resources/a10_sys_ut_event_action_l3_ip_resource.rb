resource_name :a10_sys_ut_event_action_l3_ip

property :a10_name, String, name_property: true
property :ve, String
property :virtual_server, String
property :src_dst, ['dest','src'],required: true
property :nat_pool, String
property :trunk, String
property :ipv6_address, String
property :ethernet, String
property :ipv4_address, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3/ip/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3/ip/%<src-dst>s"
    ve = new_resource.ve
    virtual_server = new_resource.virtual_server
    src_dst = new_resource.src_dst
    nat_pool = new_resource.nat_pool
    trunk = new_resource.trunk
    ipv6_address = new_resource.ipv6_address
    ethernet = new_resource.ethernet
    ipv4_address = new_resource.ipv4_address
    uuid = new_resource.uuid

    params = { "ip": {"ve": ve,
        "virtual-server": virtual_server,
        "src-dst": src_dst,
        "nat-pool": nat_pool,
        "trunk": trunk,
        "ipv6-address": ipv6_address,
        "ethernet": ethernet,
        "ipv4-address": ipv4_address,
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
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3/ip/%<src-dst>s"
    ve = new_resource.ve
    virtual_server = new_resource.virtual_server
    src_dst = new_resource.src_dst
    nat_pool = new_resource.nat_pool
    trunk = new_resource.trunk
    ipv6_address = new_resource.ipv6_address
    ethernet = new_resource.ethernet
    ipv4_address = new_resource.ipv4_address
    uuid = new_resource.uuid

    params = { "ip": {"ve": ve,
        "virtual-server": virtual_server,
        "src-dst": src_dst,
        "nat-pool": nat_pool,
        "trunk": trunk,
        "ipv6-address": ipv6_address,
        "ethernet": ethernet,
        "ipv4-address": ipv4_address,
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
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3/ip/%<src-dst>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end