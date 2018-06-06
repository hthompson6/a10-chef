resource_name :a10_system_big_buff_pool

property :a10_name, String, name_property: true
property :big_buff_pool, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-big-buff-pool"
    big_buff_pool = new_resource.big_buff_pool

    params = { "system-big-buff-pool": {"big-buff-pool": big_buff_pool,} }

    params[:"system-big-buff-pool"].each do |k, v|
        if not v 
            params[:"system-big-buff-pool"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-big-buff-pool') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-big-buff-pool"
    big_buff_pool = new_resource.big_buff_pool

    params = { "system-big-buff-pool": {"big-buff-pool": big_buff_pool,} }

    params[:"system-big-buff-pool"].each do |k, v|
        if not v
            params[:"system-big-buff-pool"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-big-buff-pool"].each do |k, v|
        if v != params[:"system-big-buff-pool"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-big-buff-pool') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-big-buff-pool"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-big-buff-pool') do
            client.delete(url)
        end
    end
end