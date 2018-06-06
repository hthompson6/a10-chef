resource_name :a10_snmp_server_enable_traps_slb

property :a10_name, String, name_property: true
property :all, [true, false]
property :server_down, [true, false]
property :vip_port_connratelimit, [true, false]
property :server_selection_failure, [true, false]
property :service_group_down, [true, false]
property :server_conn_limit, [true, false]
property :service_group_member_up, [true, false]
property :uuid, String
property :server_conn_resume, [true, false]
property :service_up, [true, false]
property :service_conn_limit, [true, false]
property :gateway_up, [true, false]
property :service_group_up, [true, false]
property :application_buffer_limit, [true, false]
property :vip_connratelimit, [true, false]
property :vip_connlimit, [true, false]
property :service_group_member_down, [true, false]
property :service_down, [true, false]
property :bw_rate_limit_exceed, [true, false]
property :server_disabled, [true, false]
property :server_up, [true, false]
property :vip_port_connlimit, [true, false]
property :vip_port_down, [true, false]
property :bw_rate_limit_resume, [true, false]
property :gateway_down, [true, false]
property :vip_up, [true, false]
property :vip_port_up, [true, false]
property :vip_down, [true, false]
property :service_conn_resume, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/slb"
    all = new_resource.all
    server_down = new_resource.server_down
    vip_port_connratelimit = new_resource.vip_port_connratelimit
    server_selection_failure = new_resource.server_selection_failure
    service_group_down = new_resource.service_group_down
    server_conn_limit = new_resource.server_conn_limit
    service_group_member_up = new_resource.service_group_member_up
    uuid = new_resource.uuid
    server_conn_resume = new_resource.server_conn_resume
    service_up = new_resource.service_up
    service_conn_limit = new_resource.service_conn_limit
    gateway_up = new_resource.gateway_up
    service_group_up = new_resource.service_group_up
    application_buffer_limit = new_resource.application_buffer_limit
    vip_connratelimit = new_resource.vip_connratelimit
    vip_connlimit = new_resource.vip_connlimit
    service_group_member_down = new_resource.service_group_member_down
    service_down = new_resource.service_down
    bw_rate_limit_exceed = new_resource.bw_rate_limit_exceed
    server_disabled = new_resource.server_disabled
    server_up = new_resource.server_up
    vip_port_connlimit = new_resource.vip_port_connlimit
    vip_port_down = new_resource.vip_port_down
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    gateway_down = new_resource.gateway_down
    vip_up = new_resource.vip_up
    vip_port_up = new_resource.vip_port_up
    vip_down = new_resource.vip_down
    service_conn_resume = new_resource.service_conn_resume

    params = { "slb": {"all": all,
        "server-down": server_down,
        "vip-port-connratelimit": vip_port_connratelimit,
        "server-selection-failure": server_selection_failure,
        "service-group-down": service_group_down,
        "server-conn-limit": server_conn_limit,
        "service-group-member-up": service_group_member_up,
        "uuid": uuid,
        "server-conn-resume": server_conn_resume,
        "service-up": service_up,
        "service-conn-limit": service_conn_limit,
        "gateway-up": gateway_up,
        "service-group-up": service_group_up,
        "application-buffer-limit": application_buffer_limit,
        "vip-connratelimit": vip_connratelimit,
        "vip-connlimit": vip_connlimit,
        "service-group-member-down": service_group_member_down,
        "service-down": service_down,
        "bw-rate-limit-exceed": bw_rate_limit_exceed,
        "server-disabled": server_disabled,
        "server-up": server_up,
        "vip-port-connlimit": vip_port_connlimit,
        "vip-port-down": vip_port_down,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "gateway-down": gateway_down,
        "vip-up": vip_up,
        "vip-port-up": vip_port_up,
        "vip-down": vip_down,
        "service-conn-resume": service_conn_resume,} }

    params[:"slb"].each do |k, v|
        if not v 
            params[:"slb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating slb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/slb"
    all = new_resource.all
    server_down = new_resource.server_down
    vip_port_connratelimit = new_resource.vip_port_connratelimit
    server_selection_failure = new_resource.server_selection_failure
    service_group_down = new_resource.service_group_down
    server_conn_limit = new_resource.server_conn_limit
    service_group_member_up = new_resource.service_group_member_up
    uuid = new_resource.uuid
    server_conn_resume = new_resource.server_conn_resume
    service_up = new_resource.service_up
    service_conn_limit = new_resource.service_conn_limit
    gateway_up = new_resource.gateway_up
    service_group_up = new_resource.service_group_up
    application_buffer_limit = new_resource.application_buffer_limit
    vip_connratelimit = new_resource.vip_connratelimit
    vip_connlimit = new_resource.vip_connlimit
    service_group_member_down = new_resource.service_group_member_down
    service_down = new_resource.service_down
    bw_rate_limit_exceed = new_resource.bw_rate_limit_exceed
    server_disabled = new_resource.server_disabled
    server_up = new_resource.server_up
    vip_port_connlimit = new_resource.vip_port_connlimit
    vip_port_down = new_resource.vip_port_down
    bw_rate_limit_resume = new_resource.bw_rate_limit_resume
    gateway_down = new_resource.gateway_down
    vip_up = new_resource.vip_up
    vip_port_up = new_resource.vip_port_up
    vip_down = new_resource.vip_down
    service_conn_resume = new_resource.service_conn_resume

    params = { "slb": {"all": all,
        "server-down": server_down,
        "vip-port-connratelimit": vip_port_connratelimit,
        "server-selection-failure": server_selection_failure,
        "service-group-down": service_group_down,
        "server-conn-limit": server_conn_limit,
        "service-group-member-up": service_group_member_up,
        "uuid": uuid,
        "server-conn-resume": server_conn_resume,
        "service-up": service_up,
        "service-conn-limit": service_conn_limit,
        "gateway-up": gateway_up,
        "service-group-up": service_group_up,
        "application-buffer-limit": application_buffer_limit,
        "vip-connratelimit": vip_connratelimit,
        "vip-connlimit": vip_connlimit,
        "service-group-member-down": service_group_member_down,
        "service-down": service_down,
        "bw-rate-limit-exceed": bw_rate_limit_exceed,
        "server-disabled": server_disabled,
        "server-up": server_up,
        "vip-port-connlimit": vip_port_connlimit,
        "vip-port-down": vip_port_down,
        "bw-rate-limit-resume": bw_rate_limit_resume,
        "gateway-down": gateway_down,
        "vip-up": vip_up,
        "vip-port-up": vip_port_up,
        "vip-down": vip_down,
        "service-conn-resume": service_conn_resume,} }

    params[:"slb"].each do |k, v|
        if not v
            params[:"slb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["slb"].each do |k, v|
        if v != params[:"slb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating slb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/slb"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting slb') do
            client.delete(url)
        end
    end
end