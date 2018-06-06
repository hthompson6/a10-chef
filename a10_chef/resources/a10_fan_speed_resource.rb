resource_name :a10_fan_speed

property :a10_name, String, name_property: true
property :a10_action, ['auto','max']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/fan-speed"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "fan-speed": {"action": a10_action,
        "uuid": uuid,} }

    params[:"fan-speed"].each do |k, v|
        if not v 
            params[:"fan-speed"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating fan-speed') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fan-speed"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "fan-speed": {"action": a10_action,
        "uuid": uuid,} }

    params[:"fan-speed"].each do |k, v|
        if not v
            params[:"fan-speed"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["fan-speed"].each do |k, v|
        if v != params[:"fan-speed"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating fan-speed') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fan-speed"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting fan-speed') do
            client.delete(url)
        end
    end
end