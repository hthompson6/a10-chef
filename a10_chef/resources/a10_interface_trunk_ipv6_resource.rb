resource_name :a10_interface_trunk_ipv6

property :a10_name, String, name_property: true
property :uuid, String
property :address_list, Array
property :router_adver, Hash
property :rip, Hash
property :ipv6_enable, [true, false]
property :stateful_firewall, Hash
property :nat, Hash
property :ttl_ignore, [true, false]
property :router, Hash
property :access_list_cfg, Hash
property :ospf, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/trunk/%<ifnum>s/"
    get_url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6"
    uuid = new_resource.uuid
    address_list = new_resource.address_list
    router_adver = new_resource.router_adver
    rip = new_resource.rip
    ipv6_enable = new_resource.ipv6_enable
    stateful_firewall = new_resource.stateful_firewall
    nat = new_resource.nat
    ttl_ignore = new_resource.ttl_ignore
    router = new_resource.router
    access_list_cfg = new_resource.access_list_cfg
    ospf = new_resource.ospf

    params = { "ipv6": {"uuid": uuid,
        "address-list": address_list,
        "router-adver": router_adver,
        "rip": rip,
        "ipv6-enable": ipv6_enable,
        "stateful-firewall": stateful_firewall,
        "nat": nat,
        "ttl-ignore": ttl_ignore,
        "router": router,
        "access-list-cfg": access_list_cfg,
        "ospf": ospf,} }

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
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6"
    uuid = new_resource.uuid
    address_list = new_resource.address_list
    router_adver = new_resource.router_adver
    rip = new_resource.rip
    ipv6_enable = new_resource.ipv6_enable
    stateful_firewall = new_resource.stateful_firewall
    nat = new_resource.nat
    ttl_ignore = new_resource.ttl_ignore
    router = new_resource.router
    access_list_cfg = new_resource.access_list_cfg
    ospf = new_resource.ospf

    params = { "ipv6": {"uuid": uuid,
        "address-list": address_list,
        "router-adver": router_adver,
        "rip": rip,
        "ipv6-enable": ipv6_enable,
        "stateful-firewall": stateful_firewall,
        "nat": nat,
        "ttl-ignore": ttl_ignore,
        "router": router,
        "access-list-cfg": access_list_cfg,
        "ospf": ospf,} }

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
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end