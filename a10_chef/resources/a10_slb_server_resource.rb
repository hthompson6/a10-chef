resource_name :a10_slb_server

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :port_list, Array
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :spoofing_cache, [true, false]
property :weight, Integer
property :slow_start, [true, false]
property :conn_limit, Integer
property :uuid, String
property :fqdn_name, String
property :external_ip, String
property :ipv6, String
property :template_server, String
property :server_ipv6_addr, String
property :alternate_server, Array
property :host, String
property :extended_stats, [true, false]
property :conn_resume, Integer
property :user_tag, String
property :sampling_enable, Array
property :a10_action, ['enable','disable','disable-with-health-check']
property :health_check, String
property :no_logging, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/server/"
    get_url = "/axapi/v3/slb/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    stats_data_action = new_resource.stats_data_action
    spoofing_cache = new_resource.spoofing_cache
    weight = new_resource.weight
    slow_start = new_resource.slow_start
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    fqdn_name = new_resource.fqdn_name
    external_ip = new_resource.external_ip
    ipv6 = new_resource.ipv6
    template_server = new_resource.template_server
    server_ipv6_addr = new_resource.server_ipv6_addr
    alternate_server = new_resource.alternate_server
    host = new_resource.host
    extended_stats = new_resource.extended_stats
    conn_resume = new_resource.conn_resume
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    health_check = new_resource.health_check
    no_logging = new_resource.no_logging

    params = { "server": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "stats-data-action": stats_data_action,
        "spoofing-cache": spoofing_cache,
        "weight": weight,
        "slow-start": slow_start,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "fqdn-name": fqdn_name,
        "external-ip": external_ip,
        "ipv6": ipv6,
        "template-server": template_server,
        "server-ipv6-addr": server_ipv6_addr,
        "alternate-server": alternate_server,
        "host": host,
        "extended-stats": extended_stats,
        "conn-resume": conn_resume,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "health-check": health_check,
        "no-logging": no_logging,} }

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
    url = "/axapi/v3/slb/server/%<name>s"
    health_check_disable = new_resource.health_check_disable
    port_list = new_resource.port_list
    stats_data_action = new_resource.stats_data_action
    spoofing_cache = new_resource.spoofing_cache
    weight = new_resource.weight
    slow_start = new_resource.slow_start
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    fqdn_name = new_resource.fqdn_name
    external_ip = new_resource.external_ip
    ipv6 = new_resource.ipv6
    template_server = new_resource.template_server
    server_ipv6_addr = new_resource.server_ipv6_addr
    alternate_server = new_resource.alternate_server
    host = new_resource.host
    extended_stats = new_resource.extended_stats
    conn_resume = new_resource.conn_resume
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    health_check = new_resource.health_check
    no_logging = new_resource.no_logging

    params = { "server": {"health-check-disable": health_check_disable,
        "port-list": port_list,
        "stats-data-action": stats_data_action,
        "spoofing-cache": spoofing_cache,
        "weight": weight,
        "slow-start": slow_start,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "fqdn-name": fqdn_name,
        "external-ip": external_ip,
        "ipv6": ipv6,
        "template-server": template_server,
        "server-ipv6-addr": server_ipv6_addr,
        "alternate-server": alternate_server,
        "host": host,
        "extended-stats": extended_stats,
        "conn-resume": conn_resume,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "health-check": health_check,
        "no-logging": no_logging,} }

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
    url = "/axapi/v3/slb/server/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server') do
            client.delete(url)
        end
    end
end