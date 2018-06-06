resource_name :a10_router_bgp_address_family_ipv6_redistribute

property :a10_name, String, name_property: true
property :ip_nat_list_cfg, Hash
property :lw4o6_cfg, Hash
property :nat64_cfg, Hash
property :uuid, String
property :connected_cfg, Hash
property :ip_nat_cfg, Hash
property :floating_ip_cfg, Hash
property :isis_cfg, Hash
property :vip, Hash
property :rip_cfg, Hash
property :ospf_cfg, Hash
property :static_cfg, Hash
property :nat_map_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/redistribute"
    ip_nat_list_cfg = new_resource.ip_nat_list_cfg
    lw4o6_cfg = new_resource.lw4o6_cfg
    nat64_cfg = new_resource.nat64_cfg
    uuid = new_resource.uuid
    connected_cfg = new_resource.connected_cfg
    ip_nat_cfg = new_resource.ip_nat_cfg
    floating_ip_cfg = new_resource.floating_ip_cfg
    isis_cfg = new_resource.isis_cfg
    vip = new_resource.vip
    rip_cfg = new_resource.rip_cfg
    ospf_cfg = new_resource.ospf_cfg
    static_cfg = new_resource.static_cfg
    nat_map_cfg = new_resource.nat_map_cfg

    params = { "redistribute": {"ip-nat-list-cfg": ip_nat_list_cfg,
        "lw4o6-cfg": lw4o6_cfg,
        "nat64-cfg": nat64_cfg,
        "uuid": uuid,
        "connected-cfg": connected_cfg,
        "ip-nat-cfg": ip_nat_cfg,
        "floating-ip-cfg": floating_ip_cfg,
        "isis-cfg": isis_cfg,
        "vip": vip,
        "rip-cfg": rip_cfg,
        "ospf-cfg": ospf_cfg,
        "static-cfg": static_cfg,
        "nat-map-cfg": nat_map_cfg,} }

    params[:"redistribute"].each do |k, v|
        if not v 
            params[:"redistribute"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating redistribute') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/redistribute"
    ip_nat_list_cfg = new_resource.ip_nat_list_cfg
    lw4o6_cfg = new_resource.lw4o6_cfg
    nat64_cfg = new_resource.nat64_cfg
    uuid = new_resource.uuid
    connected_cfg = new_resource.connected_cfg
    ip_nat_cfg = new_resource.ip_nat_cfg
    floating_ip_cfg = new_resource.floating_ip_cfg
    isis_cfg = new_resource.isis_cfg
    vip = new_resource.vip
    rip_cfg = new_resource.rip_cfg
    ospf_cfg = new_resource.ospf_cfg
    static_cfg = new_resource.static_cfg
    nat_map_cfg = new_resource.nat_map_cfg

    params = { "redistribute": {"ip-nat-list-cfg": ip_nat_list_cfg,
        "lw4o6-cfg": lw4o6_cfg,
        "nat64-cfg": nat64_cfg,
        "uuid": uuid,
        "connected-cfg": connected_cfg,
        "ip-nat-cfg": ip_nat_cfg,
        "floating-ip-cfg": floating_ip_cfg,
        "isis-cfg": isis_cfg,
        "vip": vip,
        "rip-cfg": rip_cfg,
        "ospf-cfg": ospf_cfg,
        "static-cfg": static_cfg,
        "nat-map-cfg": nat_map_cfg,} }

    params[:"redistribute"].each do |k, v|
        if not v
            params[:"redistribute"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["redistribute"].each do |k, v|
        if v != params[:"redistribute"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating redistribute') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/redistribute"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting redistribute') do
            client.delete(url)
        end
    end
end