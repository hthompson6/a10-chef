resource_name :a10_system_trunk_load_balance

property :a10_name, String, name_property: true
property :use_l4, [true, false]
property :uuid, String
property :use_l3, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/trunk/"
    get_url = "/axapi/v3/system/trunk/load-balance"
    use_l4 = new_resource.use_l4
    uuid = new_resource.uuid
    use_l3 = new_resource.use_l3

    params = { "load-balance": {"use-l4": use_l4,
        "uuid": uuid,
        "use-l3": use_l3,} }

    params[:"load-balance"].each do |k, v|
        if not v 
            params[:"load-balance"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating load-balance') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/trunk/load-balance"
    use_l4 = new_resource.use_l4
    uuid = new_resource.uuid
    use_l3 = new_resource.use_l3

    params = { "load-balance": {"use-l4": use_l4,
        "uuid": uuid,
        "use-l3": use_l3,} }

    params[:"load-balance"].each do |k, v|
        if not v
            params[:"load-balance"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["load-balance"].each do |k, v|
        if v != params[:"load-balance"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating load-balance') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/trunk/load-balance"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting load-balance') do
            client.delete(url)
        end
    end
end