resource_name :a10_system_io_cpu

property :a10_name, String, name_property: true
property :max_cores, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/io-cpu"
    max_cores = new_resource.max_cores

    params = { "io-cpu": {"max-cores": max_cores,} }

    params[:"io-cpu"].each do |k, v|
        if not v 
            params[:"io-cpu"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating io-cpu') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/io-cpu"
    max_cores = new_resource.max_cores

    params = { "io-cpu": {"max-cores": max_cores,} }

    params[:"io-cpu"].each do |k, v|
        if not v
            params[:"io-cpu"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["io-cpu"].each do |k, v|
        if v != params[:"io-cpu"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating io-cpu') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/io-cpu"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting io-cpu') do
            client.delete(url)
        end
    end
end