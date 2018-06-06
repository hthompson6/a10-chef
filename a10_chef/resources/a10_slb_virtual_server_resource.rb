resource_name :a10_slb_virtual_server

property :a10_name, String, name_property: true
property :port_list, Array
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :acl_name, String
property :enable_disable_action, ['enable','disable','disable-when-all-ports-down','disable-when-any-port-down']
property :redistribute_route_map, String
property :ip_address, String
property :template_logging, String
property :use_if_ip, [true, false]
property :uuid, String
property :vrid, Integer
property :disable_vip_adv, [true, false]
property :template_virtual_server, String
property :arp_disable, [true, false]
property :description, String
property :redistribution_flagged, [true, false]
property :netmask, String
property :acl_id, Integer
property :ipv6_acl, String
property :migrate_vip, Hash
property :extended_stats, [true, false]
property :template_scaleout, String
property :template_policy, String
property :user_tag, String
property :ipv6_address, String
property :ethernet, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/virtual-server/"
    get_url = "/axapi/v3/slb/virtual-server/%<name>s"
    port_list = new_resource.port_list
    stats_data_action = new_resource.stats_data_action
    acl_name = new_resource.acl_name
    enable_disable_action = new_resource.enable_disable_action
    redistribute_route_map = new_resource.redistribute_route_map
    ip_address = new_resource.ip_address
    template_logging = new_resource.template_logging
    use_if_ip = new_resource.use_if_ip
    uuid = new_resource.uuid
    vrid = new_resource.vrid
    disable_vip_adv = new_resource.disable_vip_adv
    template_virtual_server = new_resource.template_virtual_server
    arp_disable = new_resource.arp_disable
    description = new_resource.description
    redistribution_flagged = new_resource.redistribution_flagged
    netmask = new_resource.netmask
    acl_id = new_resource.acl_id
    ipv6_acl = new_resource.ipv6_acl
    migrate_vip = new_resource.migrate_vip
    extended_stats = new_resource.extended_stats
    a10_name = new_resource.a10_name
    template_scaleout = new_resource.template_scaleout
    template_policy = new_resource.template_policy
    user_tag = new_resource.user_tag
    ipv6_address = new_resource.ipv6_address
    ethernet = new_resource.ethernet

    params = { "virtual-server": {"port-list": port_list,
        "stats-data-action": stats_data_action,
        "acl-name": acl_name,
        "enable-disable-action": enable_disable_action,
        "redistribute-route-map": redistribute_route_map,
        "ip-address": ip_address,
        "template-logging": template_logging,
        "use-if-ip": use_if_ip,
        "uuid": uuid,
        "vrid": vrid,
        "disable-vip-adv": disable_vip_adv,
        "template-virtual-server": template_virtual_server,
        "arp-disable": arp_disable,
        "description": description,
        "redistribution-flagged": redistribution_flagged,
        "netmask": netmask,
        "acl-id": acl_id,
        "ipv6-acl": ipv6_acl,
        "migrate-vip": migrate_vip,
        "extended-stats": extended_stats,
        "name": a10_name,
        "template-scaleout": template_scaleout,
        "template-policy": template_policy,
        "user-tag": user_tag,
        "ipv6-address": ipv6_address,
        "ethernet": ethernet,} }

    params[:"virtual-server"].each do |k, v|
        if not v 
            params[:"virtual-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating virtual-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s"
    port_list = new_resource.port_list
    stats_data_action = new_resource.stats_data_action
    acl_name = new_resource.acl_name
    enable_disable_action = new_resource.enable_disable_action
    redistribute_route_map = new_resource.redistribute_route_map
    ip_address = new_resource.ip_address
    template_logging = new_resource.template_logging
    use_if_ip = new_resource.use_if_ip
    uuid = new_resource.uuid
    vrid = new_resource.vrid
    disable_vip_adv = new_resource.disable_vip_adv
    template_virtual_server = new_resource.template_virtual_server
    arp_disable = new_resource.arp_disable
    description = new_resource.description
    redistribution_flagged = new_resource.redistribution_flagged
    netmask = new_resource.netmask
    acl_id = new_resource.acl_id
    ipv6_acl = new_resource.ipv6_acl
    migrate_vip = new_resource.migrate_vip
    extended_stats = new_resource.extended_stats
    a10_name = new_resource.a10_name
    template_scaleout = new_resource.template_scaleout
    template_policy = new_resource.template_policy
    user_tag = new_resource.user_tag
    ipv6_address = new_resource.ipv6_address
    ethernet = new_resource.ethernet

    params = { "virtual-server": {"port-list": port_list,
        "stats-data-action": stats_data_action,
        "acl-name": acl_name,
        "enable-disable-action": enable_disable_action,
        "redistribute-route-map": redistribute_route_map,
        "ip-address": ip_address,
        "template-logging": template_logging,
        "use-if-ip": use_if_ip,
        "uuid": uuid,
        "vrid": vrid,
        "disable-vip-adv": disable_vip_adv,
        "template-virtual-server": template_virtual_server,
        "arp-disable": arp_disable,
        "description": description,
        "redistribution-flagged": redistribution_flagged,
        "netmask": netmask,
        "acl-id": acl_id,
        "ipv6-acl": ipv6_acl,
        "migrate-vip": migrate_vip,
        "extended-stats": extended_stats,
        "name": a10_name,
        "template-scaleout": template_scaleout,
        "template-policy": template_policy,
        "user-tag": user_tag,
        "ipv6-address": ipv6_address,
        "ethernet": ethernet,} }

    params[:"virtual-server"].each do |k, v|
        if not v
            params[:"virtual-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["virtual-server"].each do |k, v|
        if v != params[:"virtual-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating virtual-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting virtual-server') do
            client.delete(url)
        end
    end
end