resource_name :a10_slb_template_policy_class_list_lid

property :a10_name, String, name_property: true
property :request_rate_limit, Integer
property :action_value, ['forward','reset']
property :request_per, Integer
property :bw_rate_limit, Integer
property :conn_limit, Integer
property :log, [true, false]
property :direct_action_value, ['drop','reset']
property :conn_per, Integer
property :direct_fail, [true, false]
property :conn_rate_limit, Integer
property :direct_pbslb_logging, [true, false]
property :dns64, Hash
property :lidnum, Integer,required: true
property :over_limit_action, [true, false]
property :response_code_rate_limit, Array
property :direct_service_group, String
property :uuid, String
property :request_limit, Integer
property :direct_action_interval, Integer
property :bw_per, Integer
property :interval, Integer
property :user_tag, String
property :direct_action, [true, false]
property :lockout, Integer
property :direct_logging_drp_rst, [true, false]
property :direct_pbslb_interval, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/class-list/lid/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/class-list/lid/%<lidnum>s"
    request_rate_limit = new_resource.request_rate_limit
    action_value = new_resource.action_value
    request_per = new_resource.request_per
    bw_rate_limit = new_resource.bw_rate_limit
    conn_limit = new_resource.conn_limit
    log = new_resource.log
    direct_action_value = new_resource.direct_action_value
    conn_per = new_resource.conn_per
    direct_fail = new_resource.direct_fail
    conn_rate_limit = new_resource.conn_rate_limit
    direct_pbslb_logging = new_resource.direct_pbslb_logging
    dns64 = new_resource.dns64
    lidnum = new_resource.lidnum
    over_limit_action = new_resource.over_limit_action
    response_code_rate_limit = new_resource.response_code_rate_limit
    direct_service_group = new_resource.direct_service_group
    uuid = new_resource.uuid
    request_limit = new_resource.request_limit
    direct_action_interval = new_resource.direct_action_interval
    bw_per = new_resource.bw_per
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    direct_action = new_resource.direct_action
    lockout = new_resource.lockout
    direct_logging_drp_rst = new_resource.direct_logging_drp_rst
    direct_pbslb_interval = new_resource.direct_pbslb_interval

    params = { "lid": {"request-rate-limit": request_rate_limit,
        "action-value": action_value,
        "request-per": request_per,
        "bw-rate-limit": bw_rate_limit,
        "conn-limit": conn_limit,
        "log": log,
        "direct-action-value": direct_action_value,
        "conn-per": conn_per,
        "direct-fail": direct_fail,
        "conn-rate-limit": conn_rate_limit,
        "direct-pbslb-logging": direct_pbslb_logging,
        "dns64": dns64,
        "lidnum": lidnum,
        "over-limit-action": over_limit_action,
        "response-code-rate-limit": response_code_rate_limit,
        "direct-service-group": direct_service_group,
        "uuid": uuid,
        "request-limit": request_limit,
        "direct-action-interval": direct_action_interval,
        "bw-per": bw_per,
        "interval": interval,
        "user-tag": user_tag,
        "direct-action": direct_action,
        "lockout": lockout,
        "direct-logging-drp-rst": direct_logging_drp_rst,
        "direct-pbslb-interval": direct_pbslb_interval,} }

    params[:"lid"].each do |k, v|
        if not v 
            params[:"lid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/class-list/lid/%<lidnum>s"
    request_rate_limit = new_resource.request_rate_limit
    action_value = new_resource.action_value
    request_per = new_resource.request_per
    bw_rate_limit = new_resource.bw_rate_limit
    conn_limit = new_resource.conn_limit
    log = new_resource.log
    direct_action_value = new_resource.direct_action_value
    conn_per = new_resource.conn_per
    direct_fail = new_resource.direct_fail
    conn_rate_limit = new_resource.conn_rate_limit
    direct_pbslb_logging = new_resource.direct_pbslb_logging
    dns64 = new_resource.dns64
    lidnum = new_resource.lidnum
    over_limit_action = new_resource.over_limit_action
    response_code_rate_limit = new_resource.response_code_rate_limit
    direct_service_group = new_resource.direct_service_group
    uuid = new_resource.uuid
    request_limit = new_resource.request_limit
    direct_action_interval = new_resource.direct_action_interval
    bw_per = new_resource.bw_per
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    direct_action = new_resource.direct_action
    lockout = new_resource.lockout
    direct_logging_drp_rst = new_resource.direct_logging_drp_rst
    direct_pbslb_interval = new_resource.direct_pbslb_interval

    params = { "lid": {"request-rate-limit": request_rate_limit,
        "action-value": action_value,
        "request-per": request_per,
        "bw-rate-limit": bw_rate_limit,
        "conn-limit": conn_limit,
        "log": log,
        "direct-action-value": direct_action_value,
        "conn-per": conn_per,
        "direct-fail": direct_fail,
        "conn-rate-limit": conn_rate_limit,
        "direct-pbslb-logging": direct_pbslb_logging,
        "dns64": dns64,
        "lidnum": lidnum,
        "over-limit-action": over_limit_action,
        "response-code-rate-limit": response_code_rate_limit,
        "direct-service-group": direct_service_group,
        "uuid": uuid,
        "request-limit": request_limit,
        "direct-action-interval": direct_action_interval,
        "bw-per": bw_per,
        "interval": interval,
        "user-tag": user_tag,
        "direct-action": direct_action,
        "lockout": lockout,
        "direct-logging-drp-rst": direct_logging_drp_rst,
        "direct-pbslb-interval": direct_pbslb_interval,} }

    params[:"lid"].each do |k, v|
        if not v
            params[:"lid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lid"].each do |k, v|
        if v != params[:"lid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/class-list/lid/%<lidnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lid') do
            client.delete(url)
        end
    end
end