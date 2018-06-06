resource_name :a10_slb_template_dns_class_list_lid

property :a10_name, String, name_property: true
property :action_value, ['dns-cache-disable','dns-cache-enable','forward']
property :log, [true, false]
property :lidnum, Integer,required: true
property :over_limit_action, [true, false]
property :per, Integer
property :lockout, Integer
property :user_tag, String
property :dns, Hash
property :conn_rate_limit, Integer
property :log_interval, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/dns/%<name>s/class-list/lid/"
    get_url = "/axapi/v3/slb/template/dns/%<name>s/class-list/lid/%<lidnum>s"
    action_value = new_resource.action_value
    log = new_resource.log
    lidnum = new_resource.lidnum
    over_limit_action = new_resource.over_limit_action
    per = new_resource.per
    lockout = new_resource.lockout
    user_tag = new_resource.user_tag
    dns = new_resource.dns
    conn_rate_limit = new_resource.conn_rate_limit
    log_interval = new_resource.log_interval
    uuid = new_resource.uuid

    params = { "lid": {"action-value": action_value,
        "log": log,
        "lidnum": lidnum,
        "over-limit-action": over_limit_action,
        "per": per,
        "lockout": lockout,
        "user-tag": user_tag,
        "dns": dns,
        "conn-rate-limit": conn_rate_limit,
        "log-interval": log_interval,
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
    url = "/axapi/v3/slb/template/dns/%<name>s/class-list/lid/%<lidnum>s"
    action_value = new_resource.action_value
    log = new_resource.log
    lidnum = new_resource.lidnum
    over_limit_action = new_resource.over_limit_action
    per = new_resource.per
    lockout = new_resource.lockout
    user_tag = new_resource.user_tag
    dns = new_resource.dns
    conn_rate_limit = new_resource.conn_rate_limit
    log_interval = new_resource.log_interval
    uuid = new_resource.uuid

    params = { "lid": {"action-value": action_value,
        "log": log,
        "lidnum": lidnum,
        "over-limit-action": over_limit_action,
        "per": per,
        "lockout": lockout,
        "user-tag": user_tag,
        "dns": dns,
        "conn-rate-limit": conn_rate_limit,
        "log-interval": log_interval,
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
    url = "/axapi/v3/slb/template/dns/%<name>s/class-list/lid/%<lidnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lid') do
            client.delete(url)
        end
    end
end