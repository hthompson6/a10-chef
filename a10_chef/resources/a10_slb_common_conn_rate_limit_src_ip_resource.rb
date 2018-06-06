resource_name :a10_slb_common_conn_rate_limit_src_ip

property :a10_name, String, name_property: true
property :protocol, ['tcp','udp'],required: true
property :log, [true, false]
property :lock_out, Integer
property :limit_period, ['100','1000']
property :limit, Integer
property :exceed_action, [true, false]
property :shared, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/common/conn-rate-limit/src-ip/"
    get_url = "/axapi/v3/slb/common/conn-rate-limit/src-ip/%<protocol>s"
    protocol = new_resource.protocol
    log = new_resource.log
    lock_out = new_resource.lock_out
    limit_period = new_resource.limit_period
    limit = new_resource.limit
    exceed_action = new_resource.exceed_action
    shared = new_resource.shared
    uuid = new_resource.uuid

    params = { "src-ip": {"protocol": protocol,
        "log": log,
        "lock-out": lock_out,
        "limit-period": limit_period,
        "limit": limit,
        "exceed-action": exceed_action,
        "shared": shared,
        "uuid": uuid,} }

    params[:"src-ip"].each do |k, v|
        if not v 
            params[:"src-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating src-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/common/conn-rate-limit/src-ip/%<protocol>s"
    protocol = new_resource.protocol
    log = new_resource.log
    lock_out = new_resource.lock_out
    limit_period = new_resource.limit_period
    limit = new_resource.limit
    exceed_action = new_resource.exceed_action
    shared = new_resource.shared
    uuid = new_resource.uuid

    params = { "src-ip": {"protocol": protocol,
        "log": log,
        "lock-out": lock_out,
        "limit-period": limit_period,
        "limit": limit,
        "exceed-action": exceed_action,
        "shared": shared,
        "uuid": uuid,} }

    params[:"src-ip"].each do |k, v|
        if not v
            params[:"src-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["src-ip"].each do |k, v|
        if v != params[:"src-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating src-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/common/conn-rate-limit/src-ip/%<protocol>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting src-ip') do
            client.delete(url)
        end
    end
end