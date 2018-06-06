resource_name :a10_glid

property :a10_name, String, name_property: true
property :request_limit, Integer
property :conn_limit, Integer
property :log, [true, false]
property :request_rate_limit_interval, Integer
property :dns64, Hash
property :request_rate_limit, Integer
property :user_tag, String
property :conn_rate_limit_interval, Integer
property :num, Integer,required: true
property :conn_rate_limit, Integer
property :dns, Hash
property :lockout, Integer
property :action_value, ['drop','dns-cache-disable','dns-cache-enable','forward','reset']
property :over_limit_action, [true, false]
property :log_interval, Integer
property :use_nat_pool, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/glid/"
    get_url = "/axapi/v3/glid/%<num>s"
    request_limit = new_resource.request_limit
    conn_limit = new_resource.conn_limit
    log = new_resource.log
    request_rate_limit_interval = new_resource.request_rate_limit_interval
    dns64 = new_resource.dns64
    request_rate_limit = new_resource.request_rate_limit
    user_tag = new_resource.user_tag
    conn_rate_limit_interval = new_resource.conn_rate_limit_interval
    num = new_resource.num
    conn_rate_limit = new_resource.conn_rate_limit
    dns = new_resource.dns
    lockout = new_resource.lockout
    action_value = new_resource.action_value
    over_limit_action = new_resource.over_limit_action
    log_interval = new_resource.log_interval
    use_nat_pool = new_resource.use_nat_pool
    uuid = new_resource.uuid

    params = { "glid": {"request-limit": request_limit,
        "conn-limit": conn_limit,
        "log": log,
        "request-rate-limit-interval": request_rate_limit_interval,
        "dns64": dns64,
        "request-rate-limit": request_rate_limit,
        "user-tag": user_tag,
        "conn-rate-limit-interval": conn_rate_limit_interval,
        "num": num,
        "conn-rate-limit": conn_rate_limit,
        "dns": dns,
        "lockout": lockout,
        "action-value": action_value,
        "over-limit-action": over_limit_action,
        "log-interval": log_interval,
        "use-nat-pool": use_nat_pool,
        "uuid": uuid,} }

    params[:"glid"].each do |k, v|
        if not v 
            params[:"glid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating glid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glid/%<num>s"
    request_limit = new_resource.request_limit
    conn_limit = new_resource.conn_limit
    log = new_resource.log
    request_rate_limit_interval = new_resource.request_rate_limit_interval
    dns64 = new_resource.dns64
    request_rate_limit = new_resource.request_rate_limit
    user_tag = new_resource.user_tag
    conn_rate_limit_interval = new_resource.conn_rate_limit_interval
    num = new_resource.num
    conn_rate_limit = new_resource.conn_rate_limit
    dns = new_resource.dns
    lockout = new_resource.lockout
    action_value = new_resource.action_value
    over_limit_action = new_resource.over_limit_action
    log_interval = new_resource.log_interval
    use_nat_pool = new_resource.use_nat_pool
    uuid = new_resource.uuid

    params = { "glid": {"request-limit": request_limit,
        "conn-limit": conn_limit,
        "log": log,
        "request-rate-limit-interval": request_rate_limit_interval,
        "dns64": dns64,
        "request-rate-limit": request_rate_limit,
        "user-tag": user_tag,
        "conn-rate-limit-interval": conn_rate_limit_interval,
        "num": num,
        "conn-rate-limit": conn_rate_limit,
        "dns": dns,
        "lockout": lockout,
        "action-value": action_value,
        "over-limit-action": over_limit_action,
        "log-interval": log_interval,
        "use-nat-pool": use_nat_pool,
        "uuid": uuid,} }

    params[:"glid"].each do |k, v|
        if not v
            params[:"glid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["glid"].each do |k, v|
        if v != params[:"glid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating glid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glid/%<num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting glid') do
            client.delete(url)
        end
    end
end