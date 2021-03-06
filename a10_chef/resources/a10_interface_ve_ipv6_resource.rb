resource_name :a10_interface_ve_ipv6

property :a10_name, String, name_property: true
property :uuid, String
property :inbound, [true, false]
property :address_list, Array
property :inside, [true, false]
property :ipv6_enable, [true, false]
property :rip, Hash
property :outside, [true, false]
property :stateful_firewall, Hash
property :v6_acl_name, String
property :ttl_ignore, [true, false]
property :router, Hash
property :ospf, Hash
property :router_adver, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/%<ifnum>s/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6"
    uuid = new_resource.uuid
    inbound = new_resource.inbound
    address_list = new_resource.address_list
    inside = new_resource.inside
    ipv6_enable = new_resource.ipv6_enable
    rip = new_resource.rip
    outside = new_resource.outside
    stateful_firewall = new_resource.stateful_firewall
    v6_acl_name = new_resource.v6_acl_name
    ttl_ignore = new_resource.ttl_ignore
    router = new_resource.router
    ospf = new_resource.ospf
    router_adver = new_resource.router_adver

    params = { "ipv6": {"uuid": uuid,
        "inbound": inbound,
        "address-list": address_list,
        "inside": inside,
        "ipv6-enable": ipv6_enable,
        "rip": rip,
        "outside": outside,
        "stateful-firewall": stateful_firewall,
        "v6-acl-name": v6_acl_name,
        "ttl-ignore": ttl_ignore,
        "router": router,
        "ospf": ospf,
        "router-adver": router_adver,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6"
    uuid = new_resource.uuid
    inbound = new_resource.inbound
    address_list = new_resource.address_list
    inside = new_resource.inside
    ipv6_enable = new_resource.ipv6_enable
    rip = new_resource.rip
    outside = new_resource.outside
    stateful_firewall = new_resource.stateful_firewall
    v6_acl_name = new_resource.v6_acl_name
    ttl_ignore = new_resource.ttl_ignore
    router = new_resource.router
    ospf = new_resource.ospf
    router_adver = new_resource.router_adver

    params = { "ipv6": {"uuid": uuid,
        "inbound": inbound,
        "address-list": address_list,
        "inside": inside,
        "ipv6-enable": ipv6_enable,
        "rip": rip,
        "outside": outside,
        "stateful-firewall": stateful_firewall,
        "v6-acl-name": v6_acl_name,
        "ttl-ignore": ttl_ignore,
        "router": router,
        "ospf": ospf,
        "router-adver": router_adver,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end