resource_name :a10_fw_local_log

property :a10_name, String, name_property: true
property :local_logging, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/local-log"
    local_logging = new_resource.local_logging
    uuid = new_resource.uuid

    params = { "local-log": {"local-logging": local_logging,
        "uuid": uuid,} }

    params[:"local-log"].each do |k, v|
        if not v 
            params[:"local-log"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating local-log') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/local-log"
    local_logging = new_resource.local_logging
    uuid = new_resource.uuid

    params = { "local-log": {"local-logging": local_logging,
        "uuid": uuid,} }

    params[:"local-log"].each do |k, v|
        if not v
            params[:"local-log"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["local-log"].each do |k, v|
        if v != params[:"local-log"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating local-log') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/local-log"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting local-log') do
            client.delete(url)
        end
    end
end