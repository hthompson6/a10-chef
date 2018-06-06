resource_name :a10_slb_template_server

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :slow_start, [true, false]
property :weight, Integer
property :bw_rate_limit, Integer
property :spoofing_cache, [true, false]
property :conn_limit, Integer
property :uuid, String
property :resume, Integer
property :max_dynamic_server, Integer
property :rate_interval, ['100ms','second']
property :till, Integer
property :add, Integer
property :min_ttl_ratio, Integer
property :bw_rate_limit_no_logging, [true, false]
property :dynamic_server_prefix, String
property :initial_slow_start, Integer
property :every, Integer
property :conn_limit_no_logging, [true, false]
property :extended_stats, [true, false]
property :conn_rate_limit_no_logging, [true, false]
property :bw_rate_limit_duration, Integer
property :bw_rate_limit_resume, Integer
property :bw_rate_limit_acct, ['to-server-only','from-server-only','all']
property :user_tag, String
property :times, Integer
property :log_selection_failure, [true, false]
property :conn_rate_limit, Integer
property :dns_query_interval, Integer
property :health_check, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/server/"
    get_url = "/axapi/v3/slb/template/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    stats_data_action = new_resource.stats_data_action
    slow_start = new_resource.slow_start
    weight = new_resource.weight
    bw_rate_limit = new_resource.bw_rate_limit
    spoofing_cache = new_resource.spoofing_cache
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    resume = new_resource.resume
    max_dynamic_server = new_resource.max_dynamic_server
    rate_interval = new_resource.rate_interval
    till = new_resource.till
    add = new_resource.add
    min_ttl_ratio = new_resource.min_ttl_ratio
    bw_rate_limit_no_logging = new_resource.bw_rate_limit_no_logging
    dynamic_server_prefix = new_resource.dynamic_server_prefix
    initial_slow_start = new_resource.initial_slow_start
    every = new_resource.every
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    extended_stats = new_resource.extended_stats
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    bw_rate_limit_duration = new_resource.bw_rate_limit_duration
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    bw_rate_limit_acct = new_resource.bw_rate_limit_acct
    user_tag = new_resource.user_tag
    times = new_resource.times
    log_selection_failure = new_resource.log_selection_failure
    conn_rate_limit = new_resource.conn_rate_limit
    dns_query_interval = new_resource.dns_query_interval
    health_check = new_resource.health_check

    params = { "server": {"health-check-disable": health_check_disable,
        "stats-data-action": stats_data_action,
        "slow-start": slow_start,
        "weight": weight,
        "bw-rate-limit": bw_rate_limit,
        "spoofing-cache": spoofing_cache,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "resume": resume,
        "max-dynamic-server": max_dynamic_server,
        "rate-interval": rate_interval,
        "till": till,
        "add": add,
        "min-ttl-ratio": min_ttl_ratio,
        "bw-rate-limit-no-logging": bw_rate_limit_no_logging,
        "dynamic-server-prefix": dynamic_server_prefix,
        "initial-slow-start": initial_slow_start,
        "every": every,
        "conn-limit-no-logging": conn_limit_no_logging,
        "extended-stats": extended_stats,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "bw-rate-limit-duration": bw_rate_limit_duration,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "bw-rate-limit-acct": bw_rate_limit_acct,
        "user-tag": user_tag,
        "times": times,
        "log-selection-failure": log_selection_failure,
        "conn-rate-limit": conn_rate_limit,
        "dns-query-interval": dns_query_interval,
        "health-check": health_check,} }

    params[:"server"].each do |k, v|
        if not v 
            params[:"server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    stats_data_action = new_resource.stats_data_action
    slow_start = new_resource.slow_start
    weight = new_resource.weight
    bw_rate_limit = new_resource.bw_rate_limit
    spoofing_cache = new_resource.spoofing_cache
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    resume = new_resource.resume
    max_dynamic_server = new_resource.max_dynamic_server
    rate_interval = new_resource.rate_interval
    till = new_resource.till
    add = new_resource.add
    min_ttl_ratio = new_resource.min_ttl_ratio
    bw_rate_limit_no_logging = new_resource.bw_rate_limit_no_logging
    dynamic_server_prefix = new_resource.dynamic_server_prefix
    initial_slow_start = new_resource.initial_slow_start
    every = new_resource.every
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    extended_stats = new_resource.extended_stats
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    bw_rate_limit_duration = new_resource.bw_rate_limit_duration
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    bw_rate_limit_acct = new_resource.bw_rate_limit_acct
    user_tag = new_resource.user_tag
    times = new_resource.times
    log_selection_failure = new_resource.log_selection_failure
    conn_rate_limit = new_resource.conn_rate_limit
    dns_query_interval = new_resource.dns_query_interval
    health_check = new_resource.health_check

    params = { "server": {"health-check-disable": health_check_disable,
        "stats-data-action": stats_data_action,
        "slow-start": slow_start,
        "weight": weight,
        "bw-rate-limit": bw_rate_limit,
        "spoofing-cache": spoofing_cache,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "resume": resume,
        "max-dynamic-server": max_dynamic_server,
        "rate-interval": rate_interval,
        "till": till,
        "add": add,
        "min-ttl-ratio": min_ttl_ratio,
        "bw-rate-limit-no-logging": bw_rate_limit_no_logging,
        "dynamic-server-prefix": dynamic_server_prefix,
        "initial-slow-start": initial_slow_start,
        "every": every,
        "conn-limit-no-logging": conn_limit_no_logging,
        "extended-stats": extended_stats,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "bw-rate-limit-duration": bw_rate_limit_duration,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "bw-rate-limit-acct": bw_rate_limit_acct,
        "user-tag": user_tag,
        "times": times,
        "log-selection-failure": log_selection_failure,
        "conn-rate-limit": conn_rate_limit,
        "dns-query-interval": dns_query_interval,
        "health-check": health_check,} }

    params[:"server"].each do |k, v|
        if not v
            params[:"server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["server"].each do |k, v|
        if v != params[:"server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/server/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server') do
            client.delete(url)
        end
    end
end