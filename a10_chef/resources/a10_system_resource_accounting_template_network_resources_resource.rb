resource_name :a10_system_resource_accounting_template_network_resources

property :a10_name, String, name_property: true
property :static_ipv6_route_cfg, Hash
property :uuid, String
property :ipv4_acl_line_cfg, Hash
property :static_ipv4_route_cfg, Hash
property :static_arp_cfg, Hash
property :object_group_clause_cfg, Hash
property :static_mac_cfg, Hash
property :object_group_cfg, Hash
property :static_neighbor_cfg, Hash
property :threshold, Integer
property :ipv6_acl_line_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/resource-accounting/template/%<name>s/"
    get_url = "/axapi/v3/system/resource-accounting/template/%<name>s/network-resources"
    static_ipv6_route_cfg = new_resource.static_ipv6_route_cfg
    uuid = new_resource.uuid
    ipv4_acl_line_cfg = new_resource.ipv4_acl_line_cfg
    static_ipv4_route_cfg = new_resource.static_ipv4_route_cfg
    static_arp_cfg = new_resource.static_arp_cfg
    object_group_clause_cfg = new_resource.object_group_clause_cfg
    static_mac_cfg = new_resource.static_mac_cfg
    object_group_cfg = new_resource.object_group_cfg
    static_neighbor_cfg = new_resource.static_neighbor_cfg
    threshold = new_resource.threshold
    ipv6_acl_line_cfg = new_resource.ipv6_acl_line_cfg

    params = { "network-resources": {"static-ipv6-route-cfg": static_ipv6_route_cfg,
        "uuid": uuid,
        "ipv4-acl-line-cfg": ipv4_acl_line_cfg,
        "static-ipv4-route-cfg": static_ipv4_route_cfg,
        "static-arp-cfg": static_arp_cfg,
        "object-group-clause-cfg": object_group_clause_cfg,
        "static-mac-cfg": static_mac_cfg,
        "object-group-cfg": object_group_cfg,
        "static-neighbor-cfg": static_neighbor_cfg,
        "threshold": threshold,
        "ipv6-acl-line-cfg": ipv6_acl_line_cfg,} }

    params[:"network-resources"].each do |k, v|
        if not v 
            params[:"network-resources"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating network-resources') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/network-resources"
    static_ipv6_route_cfg = new_resource.static_ipv6_route_cfg
    uuid = new_resource.uuid
    ipv4_acl_line_cfg = new_resource.ipv4_acl_line_cfg
    static_ipv4_route_cfg = new_resource.static_ipv4_route_cfg
    static_arp_cfg = new_resource.static_arp_cfg
    object_group_clause_cfg = new_resource.object_group_clause_cfg
    static_mac_cfg = new_resource.static_mac_cfg
    object_group_cfg = new_resource.object_group_cfg
    static_neighbor_cfg = new_resource.static_neighbor_cfg
    threshold = new_resource.threshold
    ipv6_acl_line_cfg = new_resource.ipv6_acl_line_cfg

    params = { "network-resources": {"static-ipv6-route-cfg": static_ipv6_route_cfg,
        "uuid": uuid,
        "ipv4-acl-line-cfg": ipv4_acl_line_cfg,
        "static-ipv4-route-cfg": static_ipv4_route_cfg,
        "static-arp-cfg": static_arp_cfg,
        "object-group-clause-cfg": object_group_clause_cfg,
        "static-mac-cfg": static_mac_cfg,
        "object-group-cfg": object_group_cfg,
        "static-neighbor-cfg": static_neighbor_cfg,
        "threshold": threshold,
        "ipv6-acl-line-cfg": ipv6_acl_line_cfg,} }

    params[:"network-resources"].each do |k, v|
        if not v
            params[:"network-resources"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["network-resources"].each do |k, v|
        if v != params[:"network-resources"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating network-resources') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/network-resources"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting network-resources') do
            client.delete(url)
        end
    end
end