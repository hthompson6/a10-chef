resource_name :a10_authorization

property :a10_name, String, name_property: true
property :debug, Integer
property :commands, Integer
property :a10_method, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/authorization"
    debug = new_resource.debug
    commands = new_resource.commands
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "authorization": {"debug": debug,
        "commands": commands,
        "method": a10_method,
        "uuid": uuid,} }

    params[:"authorization"].each do |k, v|
        if not v 
            params[:"authorization"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating authorization') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/authorization"
    debug = new_resource.debug
    commands = new_resource.commands
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "authorization": {"debug": debug,
        "commands": commands,
        "method": a10_method,
        "uuid": uuid,} }

    params[:"authorization"].each do |k, v|
        if not v
            params[:"authorization"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["authorization"].each do |k, v|
        if v != params[:"authorization"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating authorization') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/authorization"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting authorization') do
            client.delete(url)
        end
    end
end