resource_name :a10_debug_system

property :a10_name, String, name_property: true
property :debug_system_enum, ['all','aaa','import-export','ssl']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/system"
    debug_system_enum = new_resource.debug_system_enum
    uuid = new_resource.uuid

    params = { "system": {"debug_system_enum": debug_system_enum,
        "uuid": uuid,} }

    params[:"system"].each do |k, v|
        if not v 
            params[:"system"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/system"
    debug_system_enum = new_resource.debug_system_enum
    uuid = new_resource.uuid

    params = { "system": {"debug_system_enum": debug_system_enum,
        "uuid": uuid,} }

    params[:"system"].each do |k, v|
        if not v
            params[:"system"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system"].each do |k, v|
        if v != params[:"system"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/system"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system') do
            client.delete(url)
        end
    end
end