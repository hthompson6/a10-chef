resource_name :a10_debug_l7session

property :a10_name, String, name_property: true
property :uuid, String
property :level, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/l7session"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "l7session": {"uuid": uuid,
        "level": level,} }

    params[:"l7session"].each do |k, v|
        if not v 
            params[:"l7session"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l7session') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/l7session"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "l7session": {"uuid": uuid,
        "level": level,} }

    params[:"l7session"].each do |k, v|
        if not v
            params[:"l7session"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l7session"].each do |k, v|
        if v != params[:"l7session"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l7session') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/l7session"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l7session') do
            client.delete(url)
        end
    end
end