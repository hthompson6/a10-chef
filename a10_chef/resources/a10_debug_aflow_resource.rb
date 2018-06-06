resource_name :a10_debug_aflow

property :a10_name, String, name_property: true
property :uuid, String
property :level, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/aflow"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "aflow": {"uuid": uuid,
        "level": level,} }

    params[:"aflow"].each do |k, v|
        if not v 
            params[:"aflow"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating aflow') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/aflow"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "aflow": {"uuid": uuid,
        "level": level,} }

    params[:"aflow"].each do |k, v|
        if not v
            params[:"aflow"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["aflow"].each do |k, v|
        if v != params[:"aflow"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating aflow') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/aflow"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting aflow') do
            client.delete(url)
        end
    end
end