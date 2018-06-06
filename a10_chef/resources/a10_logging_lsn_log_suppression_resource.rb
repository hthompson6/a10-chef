resource_name :a10_logging_lsn_log_suppression

property :a10_name, String, name_property: true
property :count, Integer
property :uuid, String
property :time, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/lsn/"
    get_url = "/axapi/v3/logging/lsn/log-suppression"
    count = new_resource.count
    uuid = new_resource.uuid
    time = new_resource.time

    params = { "log-suppression": {"count": count,
        "uuid": uuid,
        "time": time,} }

    params[:"log-suppression"].each do |k, v|
        if not v 
            params[:"log-suppression"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log-suppression') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/lsn/log-suppression"
    count = new_resource.count
    uuid = new_resource.uuid
    time = new_resource.time

    params = { "log-suppression": {"count": count,
        "uuid": uuid,
        "time": time,} }

    params[:"log-suppression"].each do |k, v|
        if not v
            params[:"log-suppression"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log-suppression"].each do |k, v|
        if v != params[:"log-suppression"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log-suppression') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/lsn/log-suppression"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log-suppression') do
            client.delete(url)
        end
    end
end