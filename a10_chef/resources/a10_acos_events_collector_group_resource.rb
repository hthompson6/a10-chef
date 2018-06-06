resource_name :a10_acos_events_collector_group

property :a10_name, String, name_property: true
property :protocol, ['udp','tcp']
property :format, ['syslog','cef','leef']
property :rate, Integer
property :user_tag, String
property :secs, Integer
property :sampling_enable, Array
property :log_server_list, Array
property :health_check, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/collector-group/"
    get_url = "/axapi/v3/acos-events/collector-group/%<name>s"
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    format = new_resource.format
    rate = new_resource.rate
    user_tag = new_resource.user_tag
    secs = new_resource.secs
    sampling_enable = new_resource.sampling_enable
    log_server_list = new_resource.log_server_list
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "collector-group": {"protocol": protocol,
        "name": a10_name,
        "format": format,
        "rate": rate,
        "user-tag": user_tag,
        "secs": secs,
        "sampling-enable": sampling_enable,
        "log-server-list": log_server_list,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"collector-group"].each do |k, v|
        if not v 
            params[:"collector-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating collector-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/collector-group/%<name>s"
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    format = new_resource.format
    rate = new_resource.rate
    user_tag = new_resource.user_tag
    secs = new_resource.secs
    sampling_enable = new_resource.sampling_enable
    log_server_list = new_resource.log_server_list
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "collector-group": {"protocol": protocol,
        "name": a10_name,
        "format": format,
        "rate": rate,
        "user-tag": user_tag,
        "secs": secs,
        "sampling-enable": sampling_enable,
        "log-server-list": log_server_list,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"collector-group"].each do |k, v|
        if not v
            params[:"collector-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["collector-group"].each do |k, v|
        if v != params[:"collector-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating collector-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/collector-group/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting collector-group') do
            client.delete(url)
        end
    end
end