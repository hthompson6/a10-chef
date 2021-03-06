resource_name :a10_router_log

property :a10_name, String, name_property: true
property :log_buffer, [true, false]
property :uuid, String
property :file, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/"
    get_url = "/axapi/v3/router/log"
    log_buffer = new_resource.log_buffer
    uuid = new_resource.uuid
    file = new_resource.file

    params = { "log": {"log-buffer": log_buffer,
        "uuid": uuid,
        "file": file,} }

    params[:"log"].each do |k, v|
        if not v 
            params[:"log"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/log"
    log_buffer = new_resource.log_buffer
    uuid = new_resource.uuid
    file = new_resource.file

    params = { "log": {"log-buffer": log_buffer,
        "uuid": uuid,
        "file": file,} }

    params[:"log"].each do |k, v|
        if not v
            params[:"log"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log"].each do |k, v|
        if v != params[:"log"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/log"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log') do
            client.delete(url)
        end
    end
end