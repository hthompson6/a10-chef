resource_name :a10_network_arp_static

property :a10_name, String, name_property: true
property :vlan, Integer,required: true
property :uuid, String
property :mac_addr, String
property :trunk, Integer
property :ethernet, String
property :ip_addr, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/arp/static/"
    get_url = "/axapi/v3/network/arp/static/%<ip-addr>s+%<vlan>s"
    vlan = new_resource.vlan
    uuid = new_resource.uuid
    mac_addr = new_resource.mac_addr
    trunk = new_resource.trunk
    ethernet = new_resource.ethernet
    ip_addr = new_resource.ip_addr

    params = { "static": {"vlan": vlan,
        "uuid": uuid,
        "mac-addr": mac_addr,
        "trunk": trunk,
        "ethernet": ethernet,
        "ip-addr": ip_addr,} }

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
    url = "/axapi/v3/network/arp/static/%<ip-addr>s+%<vlan>s"
    vlan = new_resource.vlan
    uuid = new_resource.uuid
    mac_addr = new_resource.mac_addr
    trunk = new_resource.trunk
    ethernet = new_resource.ethernet
    ip_addr = new_resource.ip_addr

    params = { "static": {"vlan": vlan,
        "uuid": uuid,
        "mac-addr": mac_addr,
        "trunk": trunk,
        "ethernet": ethernet,
        "ip-addr": ip_addr,} }

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
    url = "/axapi/v3/network/arp/static/%<ip-addr>s+%<vlan>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static') do
            client.delete(url)
        end
    end
end