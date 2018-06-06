resource_name :a10_slb_server_port

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :protocol, ['tcp','udp'],required: true
property :weight, Integer
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :health_check_follow_port, Integer
property :template_port, String
property :conn_limit, Integer
property :uuid, String
property :sampling_enable, Array
property :no_ssl, [true, false]
property :follow_port_protocol, ['tcp','udp']
property :template_server_ssl, String
property :alternate_port, Array
property :port_number, Integer,required: true
property :extended_stats, [true, false]
property :conn_resume, Integer
property :user_tag, String
property :range, Integer
property :auth_cfg, Hash
property :a10_action, ['enable','disable','disable-with-health-check']
property :health_check, String
property :no_logging, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/server/%<name>s/port/"
    get_url = "/axapi/v3/slb/server/%<name>s/port/%<port-number>s+%<protocol>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    weight = new_resource.weight
    stats_data_action = new_resource.stats_data_action
    health_check_follow_port = new_resource.health_check_follow_port
    template_port = new_resource.template_port
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    sampling_enable = new_resource.sampling_enable
    no_ssl = new_resource.no_ssl
    follow_port_protocol = new_resource.follow_port_protocol
    template_server_ssl = new_resource.template_server_ssl
    alternate_port = new_resource.alternate_port
    port_number = new_resource.port_number
    extended_stats = new_resource.extended_stats
    conn_resume = new_resource.conn_resume
    user_tag = new_resource.user_tag
    range = new_resource.range
    auth_cfg = new_resource.auth_cfg
    a10_name = new_resource.a10_name
    health_check = new_resource.health_check
    no_logging = new_resource.no_logging

    params = { "port": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "weight": weight,
        "stats-data-action": stats_data_action,
        "health-check-follow-port": health_check_follow_port,
        "template-port": template_port,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "sampling-enable": sampling_enable,
        "no-ssl": no_ssl,
        "follow-port-protocol": follow_port_protocol,
        "template-server-ssl": template_server_ssl,
        "alternate-port": alternate_port,
        "port-number": port_number,
        "extended-stats": extended_stats,
        "conn-resume": conn_resume,
        "user-tag": user_tag,
        "range": range,
        "auth-cfg": auth_cfg,
        "action": a10_action,
        "health-check": health_check,
        "no-logging": no_logging,} }

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
    url = "/axapi/v3/slb/server/%<name>s/port/%<port-number>s+%<protocol>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    weight = new_resource.weight
    stats_data_action = new_resource.stats_data_action
    health_check_follow_port = new_resource.health_check_follow_port
    template_port = new_resource.template_port
    conn_limit = new_resource.conn_limit
    uuid = new_resource.uuid
    sampling_enable = new_resource.sampling_enable
    no_ssl = new_resource.no_ssl
    follow_port_protocol = new_resource.follow_port_protocol
    template_server_ssl = new_resource.template_server_ssl
    alternate_port = new_resource.alternate_port
    port_number = new_resource.port_number
    extended_stats = new_resource.extended_stats
    conn_resume = new_resource.conn_resume
    user_tag = new_resource.user_tag
    range = new_resource.range
    auth_cfg = new_resource.auth_cfg
    a10_name = new_resource.a10_name
    health_check = new_resource.health_check
    no_logging = new_resource.no_logging

    params = { "port": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "weight": weight,
        "stats-data-action": stats_data_action,
        "health-check-follow-port": health_check_follow_port,
        "template-port": template_port,
        "conn-limit": conn_limit,
        "uuid": uuid,
        "sampling-enable": sampling_enable,
        "no-ssl": no_ssl,
        "follow-port-protocol": follow_port_protocol,
        "template-server-ssl": template_server_ssl,
        "alternate-port": alternate_port,
        "port-number": port_number,
        "extended-stats": extended_stats,
        "conn-resume": conn_resume,
        "user-tag": user_tag,
        "range": range,
        "auth-cfg": auth_cfg,
        "action": a10_action,
        "health-check": health_check,
        "no-logging": no_logging,} }

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
    url = "/axapi/v3/slb/server/%<name>s/port/%<port-number>s+%<protocol>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port') do
            client.delete(url)
        end
    end
end