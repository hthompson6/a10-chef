resource_name :a10_slb_health_stat

property :a10_name, String, name_property: true
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/health-stat"
    sampling_enable = new_resource.sampling_enable

    params = { "health-stat": {"sampling-enable": sampling_enable,} }

    params[:"health-stat"].each do |k, v|
        if not v 
            params[:"health-stat"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating health-stat') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/health-stat"
    sampling_enable = new_resource.sampling_enable

    params = { "health-stat": {"sampling-enable": sampling_enable,} }

    params[:"health-stat"].each do |k, v|
        if not v
            params[:"health-stat"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["health-stat"].each do |k, v|
        if v != params[:"health-stat"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating health-stat') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/health-stat"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-stat') do
            client.delete(url)
        end
    end
end