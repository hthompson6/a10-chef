resource_name :a10_clock_set

property :a10_name, String, name_property: true
property :time_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/clock/"
    get_url = "/axapi/v3/clock/set"
    time_cfg = new_resource.time_cfg

    params = { "set": {"time-cfg": time_cfg,} }

    params[:"set"].each do |k, v|
        if not v 
            params[:"set"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating set') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/clock/set"
    time_cfg = new_resource.time_cfg

    params = { "set": {"time-cfg": time_cfg,} }

    params[:"set"].each do |k, v|
        if not v
            params[:"set"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["set"].each do |k, v|
        if v != params[:"set"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating set') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/clock/set"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting set') do
            client.delete(url)
        end
    end
end