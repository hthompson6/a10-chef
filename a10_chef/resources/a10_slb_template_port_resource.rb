resource_name :a10_slb_template_port

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :resel_on_reset, [true, false]
property :dest_nat, [true, false]
property :request_rate_limit, Integer
property :dynamic_member_priority, Integer
property :bw_rate_limit, Integer
property :slow_start, [true, false]
property :decrement, Integer
property :conn_limit, Integer
property :a10_retry, Integer
property :weight, Integer
property :inband_health_check, [true, false]
property :resume, Integer
property :rate_interval, ['100ms','second']
property :no_ssl, [true, false]
property :till, Integer
property :add, Integer
property :sub_group, Integer
property :bw_rate_limit_no_logging, [true, false]
property :down_grace_period, Integer
property :initial_slow_start, Integer
property :dscp, Integer
property :request_rate_interval, ['100ms','second']
property :every, Integer
property :conn_limit_no_logging, [true, false]
property :extended_stats, [true, false]
property :uuid, String
property :reset, [true, false]
property :del_session_on_server_down, [true, false]
property :conn_rate_limit_no_logging, [true, false]
property :bw_rate_limit_duration, Integer
property :bw_rate_limit_resume, Integer
property :user_tag, String
property :times, Integer
property :request_rate_no_logging, [true, false]
property :down_timer, Integer
property :conn_rate_limit, Integer
property :source_nat, String
property :reassign, Integer
property :health_check, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/port/"
    get_url = "/axapi/v3/slb/template/port/%<name>s"
    health_check_disable = new_resource.health_check_disable
    stats_data_action = new_resource.stats_data_action
    resel_on_reset = new_resource.resel_on_reset
    dest_nat = new_resource.dest_nat
    request_rate_limit = new_resource.request_rate_limit
    dynamic_member_priority = new_resource.dynamic_member_priority
    bw_rate_limit = new_resource.bw_rate_limit
    slow_start = new_resource.slow_start
    decrement = new_resource.decrement
    conn_limit = new_resource.conn_limit
    a10_name = new_resource.a10_name
    weight = new_resource.weight
    inband_health_check = new_resource.inband_health_check
    resume = new_resource.resume
    rate_interval = new_resource.rate_interval
    no_ssl = new_resource.no_ssl
    till = new_resource.till
    add = new_resource.add
    sub_group = new_resource.sub_group
    bw_rate_limit_no_logging = new_resource.bw_rate_limit_no_logging
    down_grace_period = new_resource.down_grace_period
    initial_slow_start = new_resource.initial_slow_start
    dscp = new_resource.dscp
    request_rate_interval = new_resource.request_rate_interval
    every = new_resource.every
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    extended_stats = new_resource.extended_stats
    uuid = new_resource.uuid
    reset = new_resource.reset
    del_session_on_server_down = new_resource.del_session_on_server_down
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    bw_rate_limit_duration = new_resource.bw_rate_limit_duration
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    user_tag = new_resource.user_tag
    times = new_resource.times
    request_rate_no_logging = new_resource.request_rate_no_logging
    down_timer = new_resource.down_timer
    conn_rate_limit = new_resource.conn_rate_limit
    source_nat = new_resource.source_nat
    reassign = new_resource.reassign
    health_check = new_resource.health_check

    params = { "port": {"health-check-disable": health_check_disable,
        "stats-data-action": stats_data_action,
        "resel-on-reset": resel_on_reset,
        "dest-nat": dest_nat,
        "request-rate-limit": request_rate_limit,
        "dynamic-member-priority": dynamic_member_priority,
        "bw-rate-limit": bw_rate_limit,
        "slow-start": slow_start,
        "decrement": decrement,
        "conn-limit": conn_limit,
        "retry": a10_retry,
        "weight": weight,
        "inband-health-check": inband_health_check,
        "resume": resume,
        "rate-interval": rate_interval,
        "no-ssl": no_ssl,
        "till": till,
        "add": add,
        "sub-group": sub_group,
        "bw-rate-limit-no-logging": bw_rate_limit_no_logging,
        "down-grace-period": down_grace_period,
        "initial-slow-start": initial_slow_start,
        "dscp": dscp,
        "request-rate-interval": request_rate_interval,
        "every": every,
        "conn-limit-no-logging": conn_limit_no_logging,
        "extended-stats": extended_stats,
        "uuid": uuid,
        "reset": reset,
        "del-session-on-server-down": del_session_on_server_down,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "bw-rate-limit-duration": bw_rate_limit_duration,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "user-tag": user_tag,
        "times": times,
        "request-rate-no-logging": request_rate_no_logging,
        "down-timer": down_timer,
        "conn-rate-limit": conn_rate_limit,
        "source-nat": source_nat,
        "reassign": reassign,
        "health-check": health_check,} }

    params[:"port"].each do |k, v|
        if not v 
            params[:"port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/port/%<name>s"
    health_check_disable = new_resource.health_check_disable
    stats_data_action = new_resource.stats_data_action
    resel_on_reset = new_resource.resel_on_reset
    dest_nat = new_resource.dest_nat
    request_rate_limit = new_resource.request_rate_limit
    dynamic_member_priority = new_resource.dynamic_member_priority
    bw_rate_limit = new_resource.bw_rate_limit
    slow_start = new_resource.slow_start
    decrement = new_resource.decrement
    conn_limit = new_resource.conn_limit
    a10_name = new_resource.a10_name
    weight = new_resource.weight
    inband_health_check = new_resource.inband_health_check
    resume = new_resource.resume
    rate_interval = new_resource.rate_interval
    no_ssl = new_resource.no_ssl
    till = new_resource.till
    add = new_resource.add
    sub_group = new_resource.sub_group
    bw_rate_limit_no_logging = new_resource.bw_rate_limit_no_logging
    down_grace_period = new_resource.down_grace_period
    initial_slow_start = new_resource.initial_slow_start
    dscp = new_resource.dscp
    request_rate_interval = new_resource.request_rate_interval
    every = new_resource.every
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    extended_stats = new_resource.extended_stats
    uuid = new_resource.uuid
    reset = new_resource.reset
    del_session_on_server_down = new_resource.del_session_on_server_down
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    bw_rate_limit_duration = new_resource.bw_rate_limit_duration
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    user_tag = new_resource.user_tag
    times = new_resource.times
    request_rate_no_logging = new_resource.request_rate_no_logging
    down_timer = new_resource.down_timer
    conn_rate_limit = new_resource.conn_rate_limit
    source_nat = new_resource.source_nat
    reassign = new_resource.reassign
    health_check = new_resource.health_check

    params = { "port": {"health-check-disable": health_check_disable,
        "stats-data-action": stats_data_action,
        "resel-on-reset": resel_on_reset,
        "dest-nat": dest_nat,
        "request-rate-limit": request_rate_limit,
        "dynamic-member-priority": dynamic_member_priority,
        "bw-rate-limit": bw_rate_limit,
        "slow-start": slow_start,
        "decrement": decrement,
        "conn-limit": conn_limit,
        "retry": a10_retry,
        "weight": weight,
        "inband-health-check": inband_health_check,
        "resume": resume,
        "rate-interval": rate_interval,
        "no-ssl": no_ssl,
        "till": till,
        "add": add,
        "sub-group": sub_group,
        "bw-rate-limit-no-logging": bw_rate_limit_no_logging,
        "down-grace-period": down_grace_period,
        "initial-slow-start": initial_slow_start,
        "dscp": dscp,
        "request-rate-interval": request_rate_interval,
        "every": every,
        "conn-limit-no-logging": conn_limit_no_logging,
        "extended-stats": extended_stats,
        "uuid": uuid,
        "reset": reset,
        "del-session-on-server-down": del_session_on_server_down,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "bw-rate-limit-duration": bw_rate_limit_duration,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "user-tag": user_tag,
        "times": times,
        "request-rate-no-logging": request_rate_no_logging,
        "down-timer": down_timer,
        "conn-rate-limit": conn_rate_limit,
        "source-nat": source_nat,
        "reassign": reassign,
        "health-check": health_check,} }

    params[:"port"].each do |k, v|
        if not v
            params[:"port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port"].each do |k, v|
        if v != params[:"port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/port/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port') do
            client.delete(url)
        end
    end
end