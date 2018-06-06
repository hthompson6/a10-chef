resource_name :a10_system_buff_debug

property :a10_name, String, name_property: true
property :a10_action, ['enable-buff-debug','disable-buff-debug']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-buff-debug"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "system-buff-debug": {"action": a10_action,
        "uuid": uuid,} }

    params[:"system-buff-debug"].each do |k, v|
        if not v 
            params[:"system-buff-debug"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-buff-debug') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-buff-debug"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "system-buff-debug": {"action": a10_action,
        "uuid": uuid,} }

    params[:"system-buff-debug"].each do |k, v|
        if not v
            params[:"system-buff-debug"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-buff-debug"].each do |k, v|
        if v != params[:"system-buff-debug"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-buff-debug') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-buff-debug"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-buff-debug') do
            client.delete(url)
        end
    end
end