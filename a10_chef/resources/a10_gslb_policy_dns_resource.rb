resource_name :a10_gslb_policy_dns

property :a10_name, String, name_property: true
property :server_mode_only, [true, false]
property :external_soa, [true, false]
property :server_sec, [true, false]
property :sticky_ipv6_mask, Integer
property :sticky, [true, false]
property :delegation, [true, false]
property :active_only_fail_safe, [true, false]
property :cname_detect, [true, false]
property :ttl, Integer
property :dynamic_preference, [true, false]
property :use_server_ttl, [true, false]
property :server_ptr, [true, false]
property :selected_only, [true, false]
property :ip_replace, [true, false]
property :dns_addition_mx, [true, false]
property :backup_alias, [true, false]
property :server_any, [true, false]
property :hint, ['none','answer','addition']
property :cache, [true, false]
property :external_ip, [true, false]
property :server_txt, [true, false]
property :server_addition_mx, [true, false]
property :aging_time, Integer
property :block_action, [true, false]
property :template, String
property :ipv6, Array
property :selected_only_value, Integer
property :geoloc_action, [true, false]
property :server_ns, [true, false]
property :action_type, ['drop','reject','ignore']
property :server_naptr, [true, false]
property :active_only, [true, false]
property :block_value, Array
property :server_srv, [true, false]
property :server_auto_ptr, [true, false]
property :server_cname, [true, false]
property :server_authoritative, [true, false]
property :server_full_list, [true, false]
property :dns_auto_map, [true, false]
property :block_type, ['a','aaaa','ns','mx','srv','cname','ptr','soa','txt']
property :sticky_mask, String
property :geoloc_alias, [true, false]
property :logging, ['none','query','response','both']
property :backup_server, [true, false]
property :sticky_aging_time, Integer
property :geoloc_policy, [true, false]
property :uuid, String
property :server, [true, false]
property :dynamic_weight, [true, false]
property :server_ns_list, [true, false]
property :server_auto_ns, [true, false]
property :a10_action, [true, false]
property :proxy_block_port_range_list, Array
property :server_mx, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/dns"
    server_mode_only = new_resource.server_mode_only
    external_soa = new_resource.external_soa
    server_sec = new_resource.server_sec
    sticky_ipv6_mask = new_resource.sticky_ipv6_mask
    sticky = new_resource.sticky
    delegation = new_resource.delegation
    active_only_fail_safe = new_resource.active_only_fail_safe
    cname_detect = new_resource.cname_detect
    ttl = new_resource.ttl
    dynamic_preference = new_resource.dynamic_preference
    use_server_ttl = new_resource.use_server_ttl
    server_ptr = new_resource.server_ptr
    selected_only = new_resource.selected_only
    ip_replace = new_resource.ip_replace
    dns_addition_mx = new_resource.dns_addition_mx
    backup_alias = new_resource.backup_alias
    server_any = new_resource.server_any
    hint = new_resource.hint
    cache = new_resource.cache
    external_ip = new_resource.external_ip
    server_txt = new_resource.server_txt
    server_addition_mx = new_resource.server_addition_mx
    aging_time = new_resource.aging_time
    block_action = new_resource.block_action
    template = new_resource.template
    ipv6 = new_resource.ipv6
    selected_only_value = new_resource.selected_only_value
    geoloc_action = new_resource.geoloc_action
    server_ns = new_resource.server_ns
    action_type = new_resource.action_type
    server_naptr = new_resource.server_naptr
    active_only = new_resource.active_only
    block_value = new_resource.block_value
    server_srv = new_resource.server_srv
    server_auto_ptr = new_resource.server_auto_ptr
    server_cname = new_resource.server_cname
    server_authoritative = new_resource.server_authoritative
    server_full_list = new_resource.server_full_list
    dns_auto_map = new_resource.dns_auto_map
    block_type = new_resource.block_type
    sticky_mask = new_resource.sticky_mask
    geoloc_alias = new_resource.geoloc_alias
    logging = new_resource.logging
    backup_server = new_resource.backup_server
    sticky_aging_time = new_resource.sticky_aging_time
    geoloc_policy = new_resource.geoloc_policy
    uuid = new_resource.uuid
    server = new_resource.server
    dynamic_weight = new_resource.dynamic_weight
    server_ns_list = new_resource.server_ns_list
    server_auto_ns = new_resource.server_auto_ns
    a10_name = new_resource.a10_name
    proxy_block_port_range_list = new_resource.proxy_block_port_range_list
    server_mx = new_resource.server_mx

    params = { "dns": {"server-mode-only": server_mode_only,
        "external-soa": external_soa,
        "server-sec": server_sec,
        "sticky-ipv6-mask": sticky_ipv6_mask,
        "sticky": sticky,
        "delegation": delegation,
        "active-only-fail-safe": active_only_fail_safe,
        "cname-detect": cname_detect,
        "ttl": ttl,
        "dynamic-preference": dynamic_preference,
        "use-server-ttl": use_server_ttl,
        "server-ptr": server_ptr,
        "selected-only": selected_only,
        "ip-replace": ip_replace,
        "dns-addition-mx": dns_addition_mx,
        "backup-alias": backup_alias,
        "server-any": server_any,
        "hint": hint,
        "cache": cache,
        "external-ip": external_ip,
        "server-txt": server_txt,
        "server-addition-mx": server_addition_mx,
        "aging-time": aging_time,
        "block-action": block_action,
        "template": template,
        "ipv6": ipv6,
        "selected-only-value": selected_only_value,
        "geoloc-action": geoloc_action,
        "server-ns": server_ns,
        "action-type": action_type,
        "server-naptr": server_naptr,
        "active-only": active_only,
        "block-value": block_value,
        "server-srv": server_srv,
        "server-auto-ptr": server_auto_ptr,
        "server-cname": server_cname,
        "server-authoritative": server_authoritative,
        "server-full-list": server_full_list,
        "dns-auto-map": dns_auto_map,
        "block-type": block_type,
        "sticky-mask": sticky_mask,
        "geoloc-alias": geoloc_alias,
        "logging": logging,
        "backup-server": backup_server,
        "sticky-aging-time": sticky_aging_time,
        "geoloc-policy": geoloc_policy,
        "uuid": uuid,
        "server": server,
        "dynamic-weight": dynamic_weight,
        "server-ns-list": server_ns_list,
        "server-auto-ns": server_auto_ns,
        "action": a10_action,
        "proxy-block-port-range-list": proxy_block_port_range_list,
        "server-mx": server_mx,} }

    params[:"dns"].each do |k, v|
        if not v 
            params[:"dns"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/dns"
    server_mode_only = new_resource.server_mode_only
    external_soa = new_resource.external_soa
    server_sec = new_resource.server_sec
    sticky_ipv6_mask = new_resource.sticky_ipv6_mask
    sticky = new_resource.sticky
    delegation = new_resource.delegation
    active_only_fail_safe = new_resource.active_only_fail_safe
    cname_detect = new_resource.cname_detect
    ttl = new_resource.ttl
    dynamic_preference = new_resource.dynamic_preference
    use_server_ttl = new_resource.use_server_ttl
    server_ptr = new_resource.server_ptr
    selected_only = new_resource.selected_only
    ip_replace = new_resource.ip_replace
    dns_addition_mx = new_resource.dns_addition_mx
    backup_alias = new_resource.backup_alias
    server_any = new_resource.server_any
    hint = new_resource.hint
    cache = new_resource.cache
    external_ip = new_resource.external_ip
    server_txt = new_resource.server_txt
    server_addition_mx = new_resource.server_addition_mx
    aging_time = new_resource.aging_time
    block_action = new_resource.block_action
    template = new_resource.template
    ipv6 = new_resource.ipv6
    selected_only_value = new_resource.selected_only_value
    geoloc_action = new_resource.geoloc_action
    server_ns = new_resource.server_ns
    action_type = new_resource.action_type
    server_naptr = new_resource.server_naptr
    active_only = new_resource.active_only
    block_value = new_resource.block_value
    server_srv = new_resource.server_srv
    server_auto_ptr = new_resource.server_auto_ptr
    server_cname = new_resource.server_cname
    server_authoritative = new_resource.server_authoritative
    server_full_list = new_resource.server_full_list
    dns_auto_map = new_resource.dns_auto_map
    block_type = new_resource.block_type
    sticky_mask = new_resource.sticky_mask
    geoloc_alias = new_resource.geoloc_alias
    logging = new_resource.logging
    backup_server = new_resource.backup_server
    sticky_aging_time = new_resource.sticky_aging_time
    geoloc_policy = new_resource.geoloc_policy
    uuid = new_resource.uuid
    server = new_resource.server
    dynamic_weight = new_resource.dynamic_weight
    server_ns_list = new_resource.server_ns_list
    server_auto_ns = new_resource.server_auto_ns
    a10_name = new_resource.a10_name
    proxy_block_port_range_list = new_resource.proxy_block_port_range_list
    server_mx = new_resource.server_mx

    params = { "dns": {"server-mode-only": server_mode_only,
        "external-soa": external_soa,
        "server-sec": server_sec,
        "sticky-ipv6-mask": sticky_ipv6_mask,
        "sticky": sticky,
        "delegation": delegation,
        "active-only-fail-safe": active_only_fail_safe,
        "cname-detect": cname_detect,
        "ttl": ttl,
        "dynamic-preference": dynamic_preference,
        "use-server-ttl": use_server_ttl,
        "server-ptr": server_ptr,
        "selected-only": selected_only,
        "ip-replace": ip_replace,
        "dns-addition-mx": dns_addition_mx,
        "backup-alias": backup_alias,
        "server-any": server_any,
        "hint": hint,
        "cache": cache,
        "external-ip": external_ip,
        "server-txt": server_txt,
        "server-addition-mx": server_addition_mx,
        "aging-time": aging_time,
        "block-action": block_action,
        "template": template,
        "ipv6": ipv6,
        "selected-only-value": selected_only_value,
        "geoloc-action": geoloc_action,
        "server-ns": server_ns,
        "action-type": action_type,
        "server-naptr": server_naptr,
        "active-only": active_only,
        "block-value": block_value,
        "server-srv": server_srv,
        "server-auto-ptr": server_auto_ptr,
        "server-cname": server_cname,
        "server-authoritative": server_authoritative,
        "server-full-list": server_full_list,
        "dns-auto-map": dns_auto_map,
        "block-type": block_type,
        "sticky-mask": sticky_mask,
        "geoloc-alias": geoloc_alias,
        "logging": logging,
        "backup-server": backup_server,
        "sticky-aging-time": sticky_aging_time,
        "geoloc-policy": geoloc_policy,
        "uuid": uuid,
        "server": server,
        "dynamic-weight": dynamic_weight,
        "server-ns-list": server_ns_list,
        "server-auto-ns": server_auto_ns,
        "action": a10_action,
        "proxy-block-port-range-list": proxy_block_port_range_list,
        "server-mx": server_mx,} }

    params[:"dns"].each do |k, v|
        if not v
            params[:"dns"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns"].each do |k, v|
        if v != params[:"dns"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/dns"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns') do
            client.delete(url)
        end
    end
end