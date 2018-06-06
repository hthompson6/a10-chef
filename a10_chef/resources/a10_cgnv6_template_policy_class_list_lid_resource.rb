resource_name :a10_cgnv6_template_policy_class_list_lid

property :a10_name, String, name_property: true
property :request_limit, Integer
property :conn_limit, Integer
property :lidnum, Integer,required: true
property :log, [true, false]
property :dns64, Hash
property :interval, Integer
property :request_rate_limit, Integer
property :user_tag, String
property :conn_per, Integer
property :request_per, Integer
property :conn_rate_limit, Integer
property :lockout, Integer
property :action_value, ['forward','reset']
property :over_limit_action, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/policy/%<name>s/class-list/lid/"
    get_url = "/axapi/v3/cgnv6/template/policy/%<name>s/class-list/lid/%<lidnum>s"
    request_limit = new_resource.request_limit
    conn_limit = new_resource.conn_limit
    lidnum = new_resource.lidnum
    log = new_resource.log
    dns64 = new_resource.dns64
    interval = new_resource.interval
    request_rate_limit = new_resource.request_rate_limit
    user_tag = new_resource.user_tag
    conn_per = new_resource.conn_per
    request_per = new_resource.request_per
    conn_rate_limit = new_resource.conn_rate_limit
    lockout = new_resource.lockout
    action_value = new_resource.action_value
    over_limit_action = new_resource.over_limit_action
    uuid = new_resource.uuid

    params = { "lid": {"request-limit": request_limit,
        "conn-limit": conn_limit,
        "lidnum": lidnum,
        "log": log,
        "dns64": dns64,
        "interval": interval,
        "request-rate-limit": request_rate_limit,
        "user-tag": user_tag,
        "conn-per": conn_per,
        "request-per": request_per,
        "conn-rate-limit": conn_rate_limit,
        "lockout": lockout,
        "action-value": action_value,
        "over-limit-action": over_limit_action,
        "uuid": uuid,} }

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
    url = "/axapi/v3/cgnv6/template/policy/%<name>s/class-list/lid/%<lidnum>s"
    request_limit = new_resource.request_limit
    conn_limit = new_resource.conn_limit
    lidnum = new_resource.lidnum
    log = new_resource.log
    dns64 = new_resource.dns64
    interval = new_resource.interval
    request_rate_limit = new_resource.request_rate_limit
    user_tag = new_resource.user_tag
    conn_per = new_resource.conn_per
    request_per = new_resource.request_per
    conn_rate_limit = new_resource.conn_rate_limit
    lockout = new_resource.lockout
    action_value = new_resource.action_value
    over_limit_action = new_resource.over_limit_action
    uuid = new_resource.uuid

    params = { "lid": {"request-limit": request_limit,
        "conn-limit": conn_limit,
        "lidnum": lidnum,
        "log": log,
        "dns64": dns64,
        "interval": interval,
        "request-rate-limit": request_rate_limit,
        "user-tag": user_tag,
        "conn-per": conn_per,
        "request-per": request_per,
        "conn-rate-limit": conn_rate_limit,
        "lockout": lockout,
        "action-value": action_value,
        "over-limit-action": over_limit_action,
        "uuid": uuid,} }

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
    url = "/axapi/v3/cgnv6/template/policy/%<name>s/class-list/lid/%<lidnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lid') do
            client.delete(url)
        end
    end
end