resource_name :a10_slb_service_group

property :a10_name, String, name_property: true
property :conn_rate, Integer
property :reset_on_server_selection_fail, [true, false]
property :health_check_disable, [true, false]
property :protocol, ['tcp','udp']
property :traffic_replication_mirror_ip_repl, [true, false]
property :reset_priority_affinity, [true, false]
property :priorities, Array
property :min_active_member, Integer
property :member_list, Array
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :traffic_replication_mirror_da_repl, [true, false]
property :rpt_ext_server, [true, false]
property :template_port, String
property :conn_rate_grace_period, Integer
property :l4_session_usage_duration, Integer
property :uuid, String
property :backup_server_event_log, [true, false]
property :lc_method, ['least-connection','service-least-connection','weighted-least-connection','service-weighted-least-connection']
property :pseudo_round_robin, [true, false]
property :l4_session_usage_revert_rate, Integer
property :template_server, String
property :traffic_replication_mirror, [true, false]
property :l4_session_revert_duration, Integer
property :traffic_replication_mirror_sa_da_repl, [true, false]
property :lb_method, ['dst-ip-hash','dst-ip-only-hash','fastest-response','least-request','src-ip-hash','src-ip-only-hash','weighted-rr','round-robin','round-robin-strict','odd-even-hash']
property :stateless_auto_switch, [true, false]
property :min_active_member_action, ['dynamic-priority','skip-pri-set']
property :l4_session_usage, Integer
property :extended_stats, [true, false]
property :conn_rate_revert_duration, Integer
property :strict_select, [true, false]
property :reset, Hash
property :traffic_replication_mirror_sa_repl, [true, false]
property :report_delay, Integer
property :conn_rate_log, [true, false]
property :l4_session_usage_log, [true, false]
property :conn_rate_duration, Integer
property :stateless_lb_method, ['stateless-dst-ip-hash','stateless-per-pkt-round-robin','stateless-src-dst-ip-hash','stateless-src-dst-ip-only-hash','stateless-src-ip-hash','stateless-src-ip-only-hash']
property :template_policy, String
property :stateless_lb_method2, ['stateless-dst-ip-hash','stateless-per-pkt-round-robin','stateless-src-dst-ip-hash','stateless-src-dst-ip-only-hash','stateless-src-ip-hash','stateless-src-ip-only-hash']
property :user_tag, String
property :sample_rsp_time, [true, false]
property :sampling_enable, Array
property :top_fastest, [true, false]
property :conn_revert_rate, Integer
property :l4_session_usage_grace_period, Integer
property :priority_affinity, [true, false]
property :top_slowest, [true, false]
property :health_check, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/service-group/"
    get_url = "/axapi/v3/slb/service-group/%<name>s"
    conn_rate = new_resource.conn_rate
    reset_on_server_selection_fail = new_resource.reset_on_server_selection_fail
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    traffic_replication_mirror_ip_repl = new_resource.traffic_replication_mirror_ip_repl
    reset_priority_affinity = new_resource.reset_priority_affinity
    priorities = new_resource.priorities
    min_active_member = new_resource.min_active_member
    member_list = new_resource.member_list
    stats_data_action = new_resource.stats_data_action
    traffic_replication_mirror_da_repl = new_resource.traffic_replication_mirror_da_repl
    rpt_ext_server = new_resource.rpt_ext_server
    template_port = new_resource.template_port
    conn_rate_grace_period = new_resource.conn_rate_grace_period
    l4_session_usage_duration = new_resource.l4_session_usage_duration
    uuid = new_resource.uuid
    backup_server_event_log = new_resource.backup_server_event_log
    lc_method = new_resource.lc_method
    pseudo_round_robin = new_resource.pseudo_round_robin
    l4_session_usage_revert_rate = new_resource.l4_session_usage_revert_rate
    template_server = new_resource.template_server
    traffic_replication_mirror = new_resource.traffic_replication_mirror
    l4_session_revert_duration = new_resource.l4_session_revert_duration
    traffic_replication_mirror_sa_da_repl = new_resource.traffic_replication_mirror_sa_da_repl
    lb_method = new_resource.lb_method
    stateless_auto_switch = new_resource.stateless_auto_switch
    min_active_member_action = new_resource.min_active_member_action
    l4_session_usage = new_resource.l4_session_usage
    extended_stats = new_resource.extended_stats
    conn_rate_revert_duration = new_resource.conn_rate_revert_duration
    strict_select = new_resource.strict_select
    a10_name = new_resource.a10_name
    reset = new_resource.reset
    traffic_replication_mirror_sa_repl = new_resource.traffic_replication_mirror_sa_repl
    report_delay = new_resource.report_delay
    conn_rate_log = new_resource.conn_rate_log
    l4_session_usage_log = new_resource.l4_session_usage_log
    conn_rate_duration = new_resource.conn_rate_duration
    stateless_lb_method = new_resource.stateless_lb_method
    template_policy = new_resource.template_policy
    stateless_lb_method2 = new_resource.stateless_lb_method2
    user_tag = new_resource.user_tag
    sample_rsp_time = new_resource.sample_rsp_time
    sampling_enable = new_resource.sampling_enable
    top_fastest = new_resource.top_fastest
    conn_revert_rate = new_resource.conn_revert_rate
    l4_session_usage_grace_period = new_resource.l4_session_usage_grace_period
    priority_affinity = new_resource.priority_affinity
    top_slowest = new_resource.top_slowest
    health_check = new_resource.health_check

    params = { "service-group": {"conn-rate": conn_rate,
        "reset-on-server-selection-fail": reset_on_server_selection_fail,
        "health-check-disable": health_check_disable,
        "protocol": protocol,
        "traffic-replication-mirror-ip-repl": traffic_replication_mirror_ip_repl,
        "reset-priority-affinity": reset_priority_affinity,
        "priorities": priorities,
        "min-active-member": min_active_member,
        "member-list": member_list,
        "stats-data-action": stats_data_action,
        "traffic-replication-mirror-da-repl": traffic_replication_mirror_da_repl,
        "rpt-ext-server": rpt_ext_server,
        "template-port": template_port,
        "conn-rate-grace-period": conn_rate_grace_period,
        "l4-session-usage-duration": l4_session_usage_duration,
        "uuid": uuid,
        "backup-server-event-log": backup_server_event_log,
        "lc-method": lc_method,
        "pseudo-round-robin": pseudo_round_robin,
        "l4-session-usage-revert-rate": l4_session_usage_revert_rate,
        "template-server": template_server,
        "traffic-replication-mirror": traffic_replication_mirror,
        "l4-session-revert-duration": l4_session_revert_duration,
        "traffic-replication-mirror-sa-da-repl": traffic_replication_mirror_sa_da_repl,
        "lb-method": lb_method,
        "stateless-auto-switch": stateless_auto_switch,
        "min-active-member-action": min_active_member_action,
        "l4-session-usage": l4_session_usage,
        "extended-stats": extended_stats,
        "conn-rate-revert-duration": conn_rate_revert_duration,
        "strict-select": strict_select,
        "name": a10_name,
        "reset": reset,
        "traffic-replication-mirror-sa-repl": traffic_replication_mirror_sa_repl,
        "report-delay": report_delay,
        "conn-rate-log": conn_rate_log,
        "l4-session-usage-log": l4_session_usage_log,
        "conn-rate-duration": conn_rate_duration,
        "stateless-lb-method": stateless_lb_method,
        "template-policy": template_policy,
        "stateless-lb-method2": stateless_lb_method2,
        "user-tag": user_tag,
        "sample-rsp-time": sample_rsp_time,
        "sampling-enable": sampling_enable,
        "top-fastest": top_fastest,
        "conn-revert-rate": conn_revert_rate,
        "l4-session-usage-grace-period": l4_session_usage_grace_period,
        "priority-affinity": priority_affinity,
        "top-slowest": top_slowest,
        "health-check": health_check,} }

    params[:"service-group"].each do |k, v|
        if not v 
            params[:"service-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/service-group/%<name>s"
    conn_rate = new_resource.conn_rate
    reset_on_server_selection_fail = new_resource.reset_on_server_selection_fail
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    traffic_replication_mirror_ip_repl = new_resource.traffic_replication_mirror_ip_repl
    reset_priority_affinity = new_resource.reset_priority_affinity
    priorities = new_resource.priorities
    min_active_member = new_resource.min_active_member
    member_list = new_resource.member_list
    stats_data_action = new_resource.stats_data_action
    traffic_replication_mirror_da_repl = new_resource.traffic_replication_mirror_da_repl
    rpt_ext_server = new_resource.rpt_ext_server
    template_port = new_resource.template_port
    conn_rate_grace_period = new_resource.conn_rate_grace_period
    l4_session_usage_duration = new_resource.l4_session_usage_duration
    uuid = new_resource.uuid
    backup_server_event_log = new_resource.backup_server_event_log
    lc_method = new_resource.lc_method
    pseudo_round_robin = new_resource.pseudo_round_robin
    l4_session_usage_revert_rate = new_resource.l4_session_usage_revert_rate
    template_server = new_resource.template_server
    traffic_replication_mirror = new_resource.traffic_replication_mirror
    l4_session_revert_duration = new_resource.l4_session_revert_duration
    traffic_replication_mirror_sa_da_repl = new_resource.traffic_replication_mirror_sa_da_repl
    lb_method = new_resource.lb_method
    stateless_auto_switch = new_resource.stateless_auto_switch
    min_active_member_action = new_resource.min_active_member_action
    l4_session_usage = new_resource.l4_session_usage
    extended_stats = new_resource.extended_stats
    conn_rate_revert_duration = new_resource.conn_rate_revert_duration
    strict_select = new_resource.strict_select
    a10_name = new_resource.a10_name
    reset = new_resource.reset
    traffic_replication_mirror_sa_repl = new_resource.traffic_replication_mirror_sa_repl
    report_delay = new_resource.report_delay
    conn_rate_log = new_resource.conn_rate_log
    l4_session_usage_log = new_resource.l4_session_usage_log
    conn_rate_duration = new_resource.conn_rate_duration
    stateless_lb_method = new_resource.stateless_lb_method
    template_policy = new_resource.template_policy
    stateless_lb_method2 = new_resource.stateless_lb_method2
    user_tag = new_resource.user_tag
    sample_rsp_time = new_resource.sample_rsp_time
    sampling_enable = new_resource.sampling_enable
    top_fastest = new_resource.top_fastest
    conn_revert_rate = new_resource.conn_revert_rate
    l4_session_usage_grace_period = new_resource.l4_session_usage_grace_period
    priority_affinity = new_resource.priority_affinity
    top_slowest = new_resource.top_slowest
    health_check = new_resource.health_check

    params = { "service-group": {"conn-rate": conn_rate,
        "reset-on-server-selection-fail": reset_on_server_selection_fail,
        "health-check-disable": health_check_disable,
        "protocol": protocol,
        "traffic-replication-mirror-ip-repl": traffic_replication_mirror_ip_repl,
        "reset-priority-affinity": reset_priority_affinity,
        "priorities": priorities,
        "min-active-member": min_active_member,
        "member-list": member_list,
        "stats-data-action": stats_data_action,
        "traffic-replication-mirror-da-repl": traffic_replication_mirror_da_repl,
        "rpt-ext-server": rpt_ext_server,
        "template-port": template_port,
        "conn-rate-grace-period": conn_rate_grace_period,
        "l4-session-usage-duration": l4_session_usage_duration,
        "uuid": uuid,
        "backup-server-event-log": backup_server_event_log,
        "lc-method": lc_method,
        "pseudo-round-robin": pseudo_round_robin,
        "l4-session-usage-revert-rate": l4_session_usage_revert_rate,
        "template-server": template_server,
        "traffic-replication-mirror": traffic_replication_mirror,
        "l4-session-revert-duration": l4_session_revert_duration,
        "traffic-replication-mirror-sa-da-repl": traffic_replication_mirror_sa_da_repl,
        "lb-method": lb_method,
        "stateless-auto-switch": stateless_auto_switch,
        "min-active-member-action": min_active_member_action,
        "l4-session-usage": l4_session_usage,
        "extended-stats": extended_stats,
        "conn-rate-revert-duration": conn_rate_revert_duration,
        "strict-select": strict_select,
        "name": a10_name,
        "reset": reset,
        "traffic-replication-mirror-sa-repl": traffic_replication_mirror_sa_repl,
        "report-delay": report_delay,
        "conn-rate-log": conn_rate_log,
        "l4-session-usage-log": l4_session_usage_log,
        "conn-rate-duration": conn_rate_duration,
        "stateless-lb-method": stateless_lb_method,
        "template-policy": template_policy,
        "stateless-lb-method2": stateless_lb_method2,
        "user-tag": user_tag,
        "sample-rsp-time": sample_rsp_time,
        "sampling-enable": sampling_enable,
        "top-fastest": top_fastest,
        "conn-revert-rate": conn_revert_rate,
        "l4-session-usage-grace-period": l4_session_usage_grace_period,
        "priority-affinity": priority_affinity,
        "top-slowest": top_slowest,
        "health-check": health_check,} }

    params[:"service-group"].each do |k, v|
        if not v
            params[:"service-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-group"].each do |k, v|
        if v != params[:"service-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/service-group/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-group') do
            client.delete(url)
        end
    end
end