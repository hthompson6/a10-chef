resource_name :a10_debug_tcp

property :a10_name, String, name_property: true
property :level, Integer
property :uuid, String
property :stack, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/tcp"
    level = new_resource.level
    uuid = new_resource.uuid
    stack = new_resource.stack

    params = { "tcp": {"level": level,
        "uuid": uuid,
        "stack": stack,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/tcp"
    level = new_resource.level
    uuid = new_resource.uuid
    stack = new_resource.stack

    params = { "tcp": {"level": level,
        "uuid": uuid,
        "stack": stack,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/tcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end