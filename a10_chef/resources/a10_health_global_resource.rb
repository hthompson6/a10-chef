resource_name :a10_health_global

property :a10_name, String, name_property: true
property :disable_auto_adjust, [true, false]
property :uuid, String
property :external_rate, Integer
property :multi_process, Integer
property :interval, Integer
property :check_rate, Integer
property :per, Integer
property :a10_retry, Integer
property :up_retry, Integer
property :timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/"
    get_url = "/axapi/v3/health/global"
    disable_auto_adjust = new_resource.disable_auto_adjust
    uuid = new_resource.uuid
    external_rate = new_resource.external_rate
    multi_process = new_resource.multi_process
    interval = new_resource.interval
    check_rate = new_resource.check_rate
    per = new_resource.per
    a10_name = new_resource.a10_name
    up_retry = new_resource.up_retry
    timeout = new_resource.timeout

    params = { "global": {"disable-auto-adjust": disable_auto_adjust,
        "uuid": uuid,
        "external-rate": external_rate,
        "multi-process": multi_process,
        "interval": interval,
        "check-rate": check_rate,
        "per": per,
        "retry": a10_retry,
        "up-retry": up_retry,
        "timeout": timeout,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/global"
    disable_auto_adjust = new_resource.disable_auto_adjust
    uuid = new_resource.uuid
    external_rate = new_resource.external_rate
    multi_process = new_resource.multi_process
    interval = new_resource.interval
    check_rate = new_resource.check_rate
    per = new_resource.per
    a10_name = new_resource.a10_name
    up_retry = new_resource.up_retry
    timeout = new_resource.timeout

    params = { "global": {"disable-auto-adjust": disable_auto_adjust,
        "uuid": uuid,
        "external-rate": external_rate,
        "multi-process": multi_process,
        "interval": interval,
        "check-rate": check_rate,
        "per": per,
        "retry": a10_retry,
        "up-retry": up_retry,
        "timeout": timeout,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end