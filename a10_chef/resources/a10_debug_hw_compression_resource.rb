resource_name :a10_debug_hw_compression

property :a10_name, String, name_property: true
property :uuid, String
property :level, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/hw-compression/"
    get_url = "/axapi/v3/debug/hw-compression/%<level>s"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "hw-compression": {"uuid": uuid,
        "level": level,} }

    params[:"hw-compression"].each do |k, v|
        if not v 
            params[:"hw-compression"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating hw-compression') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/hw-compression/%<level>s"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "hw-compression": {"uuid": uuid,
        "level": level,} }

    params[:"hw-compression"].each do |k, v|
        if not v
            params[:"hw-compression"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["hw-compression"].each do |k, v|
        if v != params[:"hw-compression"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating hw-compression') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/hw-compression/%<level>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting hw-compression') do
            client.delete(url)
        end
    end
end