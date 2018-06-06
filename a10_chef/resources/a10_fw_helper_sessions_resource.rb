resource_name :a10_fw_helper_sessions

property :a10_name, String, name_property: true
property :idle_timeout, Integer
property :limit, Integer
property :mode, ['disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/helper-sessions"
    idle_timeout = new_resource.idle_timeout
    limit = new_resource.limit
    mode = new_resource.mode
    uuid = new_resource.uuid

    params = { "helper-sessions": {"idle-timeout": idle_timeout,
        "limit": limit,
        "mode": mode,
        "uuid": uuid,} }

    params[:"helper-sessions"].each do |k, v|
        if not v 
            params[:"helper-sessions"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating helper-sessions') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/helper-sessions"
    idle_timeout = new_resource.idle_timeout
    limit = new_resource.limit
    mode = new_resource.mode
    uuid = new_resource.uuid

    params = { "helper-sessions": {"idle-timeout": idle_timeout,
        "limit": limit,
        "mode": mode,
        "uuid": uuid,} }

    params[:"helper-sessions"].each do |k, v|
        if not v
            params[:"helper-sessions"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["helper-sessions"].each do |k, v|
        if v != params[:"helper-sessions"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating helper-sessions') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/helper-sessions"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting helper-sessions') do
            client.delete(url)
        end
    end
end