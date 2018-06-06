resource_name :a10_gslb_policy

property :a10_name, String, name_property: true
property :weighted_ip_enable, [true, false]
property :alias_admin_preference, [true, false]
property :admin_ip_top_only, [true, false]
property :least_response, [true, false]
property :auto_map, Hash
property :bw_cost_fail_break, [true, false]
property :metric_fail_break, [true, false]
property :edns, Hash
property :active_rdt, Hash
property :round_robin, [true, false]
property :admin_preference, [true, false]
property :capacity, Hash
property :uuid, String
property :active_servers_fail_break, [true, false]
property :metric_type, ['health-check','weighted-ip','weighted-site','capacity','active-servers','active-rdt','geographic','connection-load','num-session','admin-preference','bw-cost','least-response','admin-ip']
property :num_session_tolerance, Integer
property :dns, Hash
property :weighted_ip_total_hits, [true, false]
property :weighted_site_total_hits, [true, false]
property :ip_list, String
property :ordered_ip_top_only, [true, false]
property :weighted_site_enable, [true, false]
property :metric_force_check, [true, false]
property :admin_ip_enable, [true, false]
property :geo_location_list, Array
property :weighted_alias, [true, false]
property :geo_location_match, Hash
property :num_session_enable, [true, false]
property :bw_cost_enable, [true, false]
property :active_servers_enable, [true, false]
property :user_tag, String
property :amount_first, [true, false]
property :connection_load, Hash
property :metric_order, [true, false]
property :health_check_preference_enable, [true, false]
property :health_preference_top, Integer
property :health_check, [true, false]
property :geographic, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/"
    get_url = "/axapi/v3/gslb/policy/%<name>s"
    weighted_ip_enable = new_resource.weighted_ip_enable
    alias_admin_preference = new_resource.alias_admin_preference
    admin_ip_top_only = new_resource.admin_ip_top_only
    least_response = new_resource.least_response
    auto_map = new_resource.auto_map
    bw_cost_fail_break = new_resource.bw_cost_fail_break
    metric_fail_break = new_resource.metric_fail_break
    edns = new_resource.edns
    active_rdt = new_resource.active_rdt
    round_robin = new_resource.round_robin
    admin_preference = new_resource.admin_preference
    capacity = new_resource.capacity
    uuid = new_resource.uuid
    active_servers_fail_break = new_resource.active_servers_fail_break
    metric_type = new_resource.metric_type
    num_session_tolerance = new_resource.num_session_tolerance
    a10_name = new_resource.a10_name
    dns = new_resource.dns
    weighted_ip_total_hits = new_resource.weighted_ip_total_hits
    weighted_site_total_hits = new_resource.weighted_site_total_hits
    ip_list = new_resource.ip_list
    ordered_ip_top_only = new_resource.ordered_ip_top_only
    weighted_site_enable = new_resource.weighted_site_enable
    metric_force_check = new_resource.metric_force_check
    admin_ip_enable = new_resource.admin_ip_enable
    geo_location_list = new_resource.geo_location_list
    weighted_alias = new_resource.weighted_alias
    geo_location_match = new_resource.geo_location_match
    num_session_enable = new_resource.num_session_enable
    bw_cost_enable = new_resource.bw_cost_enable
    active_servers_enable = new_resource.active_servers_enable
    user_tag = new_resource.user_tag
    amount_first = new_resource.amount_first
    connection_load = new_resource.connection_load
    metric_order = new_resource.metric_order
    health_check_preference_enable = new_resource.health_check_preference_enable
    health_preference_top = new_resource.health_preference_top
    health_check = new_resource.health_check
    geographic = new_resource.geographic

    params = { "policy": {"weighted-ip-enable": weighted_ip_enable,
        "alias-admin-preference": alias_admin_preference,
        "admin-ip-top-only": admin_ip_top_only,
        "least-response": least_response,
        "auto-map": auto_map,
        "bw-cost-fail-break": bw_cost_fail_break,
        "metric-fail-break": metric_fail_break,
        "edns": edns,
        "active-rdt": active_rdt,
        "round-robin": round_robin,
        "admin-preference": admin_preference,
        "capacity": capacity,
        "uuid": uuid,
        "active-servers-fail-break": active_servers_fail_break,
        "metric-type": metric_type,
        "num-session-tolerance": num_session_tolerance,
        "name": a10_name,
        "dns": dns,
        "weighted-ip-total-hits": weighted_ip_total_hits,
        "weighted-site-total-hits": weighted_site_total_hits,
        "ip-list": ip_list,
        "ordered-ip-top-only": ordered_ip_top_only,
        "weighted-site-enable": weighted_site_enable,
        "metric-force-check": metric_force_check,
        "admin-ip-enable": admin_ip_enable,
        "geo-location-list": geo_location_list,
        "weighted-alias": weighted_alias,
        "geo-location-match": geo_location_match,
        "num-session-enable": num_session_enable,
        "bw-cost-enable": bw_cost_enable,
        "active-servers-enable": active_servers_enable,
        "user-tag": user_tag,
        "amount-first": amount_first,
        "connection-load": connection_load,
        "metric-order": metric_order,
        "health-check-preference-enable": health_check_preference_enable,
        "health-preference-top": health_preference_top,
        "health-check": health_check,
        "geographic": geographic,} }

    params[:"policy"].each do |k, v|
        if not v 
            params[:"policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s"
    weighted_ip_enable = new_resource.weighted_ip_enable
    alias_admin_preference = new_resource.alias_admin_preference
    admin_ip_top_only = new_resource.admin_ip_top_only
    least_response = new_resource.least_response
    auto_map = new_resource.auto_map
    bw_cost_fail_break = new_resource.bw_cost_fail_break
    metric_fail_break = new_resource.metric_fail_break
    edns = new_resource.edns
    active_rdt = new_resource.active_rdt
    round_robin = new_resource.round_robin
    admin_preference = new_resource.admin_preference
    capacity = new_resource.capacity
    uuid = new_resource.uuid
    active_servers_fail_break = new_resource.active_servers_fail_break
    metric_type = new_resource.metric_type
    num_session_tolerance = new_resource.num_session_tolerance
    a10_name = new_resource.a10_name
    dns = new_resource.dns
    weighted_ip_total_hits = new_resource.weighted_ip_total_hits
    weighted_site_total_hits = new_resource.weighted_site_total_hits
    ip_list = new_resource.ip_list
    ordered_ip_top_only = new_resource.ordered_ip_top_only
    weighted_site_enable = new_resource.weighted_site_enable
    metric_force_check = new_resource.metric_force_check
    admin_ip_enable = new_resource.admin_ip_enable
    geo_location_list = new_resource.geo_location_list
    weighted_alias = new_resource.weighted_alias
    geo_location_match = new_resource.geo_location_match
    num_session_enable = new_resource.num_session_enable
    bw_cost_enable = new_resource.bw_cost_enable
    active_servers_enable = new_resource.active_servers_enable
    user_tag = new_resource.user_tag
    amount_first = new_resource.amount_first
    connection_load = new_resource.connection_load
    metric_order = new_resource.metric_order
    health_check_preference_enable = new_resource.health_check_preference_enable
    health_preference_top = new_resource.health_preference_top
    health_check = new_resource.health_check
    geographic = new_resource.geographic

    params = { "policy": {"weighted-ip-enable": weighted_ip_enable,
        "alias-admin-preference": alias_admin_preference,
        "admin-ip-top-only": admin_ip_top_only,
        "least-response": least_response,
        "auto-map": auto_map,
        "bw-cost-fail-break": bw_cost_fail_break,
        "metric-fail-break": metric_fail_break,
        "edns": edns,
        "active-rdt": active_rdt,
        "round-robin": round_robin,
        "admin-preference": admin_preference,
        "capacity": capacity,
        "uuid": uuid,
        "active-servers-fail-break": active_servers_fail_break,
        "metric-type": metric_type,
        "num-session-tolerance": num_session_tolerance,
        "name": a10_name,
        "dns": dns,
        "weighted-ip-total-hits": weighted_ip_total_hits,
        "weighted-site-total-hits": weighted_site_total_hits,
        "ip-list": ip_list,
        "ordered-ip-top-only": ordered_ip_top_only,
        "weighted-site-enable": weighted_site_enable,
        "metric-force-check": metric_force_check,
        "admin-ip-enable": admin_ip_enable,
        "geo-location-list": geo_location_list,
        "weighted-alias": weighted_alias,
        "geo-location-match": geo_location_match,
        "num-session-enable": num_session_enable,
        "bw-cost-enable": bw_cost_enable,
        "active-servers-enable": active_servers_enable,
        "user-tag": user_tag,
        "amount-first": amount_first,
        "connection-load": connection_load,
        "metric-order": metric_order,
        "health-check-preference-enable": health_check_preference_enable,
        "health-preference-top": health_preference_top,
        "health-check": health_check,
        "geographic": geographic,} }

    params[:"policy"].each do |k, v|
        if not v
            params[:"policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["policy"].each do |k, v|
        if v != params[:"policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting policy') do
            client.delete(url)
        end
    end
end