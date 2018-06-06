resource_name :a10_ipv6_neighbor_static

property :a10_name, String, name_property: true
property :uuid, String
property :tunnel, Integer
property :vlan, Integer,required: true
property :ipv6_addr, String,required: true
property :mac, String
property :trunk, Integer
property :ethernet, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/neighbor/static/"
    get_url = "/axapi/v3/ipv6/neighbor/static/%<ipv6-addr>s+%<vlan>s"
    uuid = new_resource.uuid
    tunnel = new_resource.tunnel
    vlan = new_resource.vlan
    ipv6_addr = new_resource.ipv6_addr
    mac = new_resource.mac
    trunk = new_resource.trunk
    ethernet = new_resource.ethernet

    params = { "static": {"uuid": uuid,
        "tunnel": tunnel,
        "vlan": vlan,
        "ipv6-addr": ipv6_addr,
        "mac": mac,
        "trunk": trunk,
        "ethernet": ethernet,} }

    params[:"static"].each do |k, v|
        if not v 
            params[:"static"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating static') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/neighbor/static/%<ipv6-addr>s+%<vlan>s"
    uuid = new_resource.uuid
    tunnel = new_resource.tunnel
    vlan = new_resource.vlan
    ipv6_addr = new_resource.ipv6_addr
    mac = new_resource.mac
    trunk = new_resource.trunk
    ethernet = new_resource.ethernet

    params = { "static": {"uuid": uuid,
        "tunnel": tunnel,
        "vlan": vlan,
        "ipv6-addr": ipv6_addr,
        "mac": mac,
        "trunk": trunk,
        "ethernet": ethernet,} }

    params[:"static"].each do |k, v|
        if not v
            params[:"static"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["static"].each do |k, v|
        if v != params[:"static"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating static') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/neighbor/static/%<ipv6-addr>s+%<vlan>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static') do
            client.delete(url)
        end
    end
end