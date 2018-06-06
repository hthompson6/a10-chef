resource_name :a10_system_del_port

property :a10_name, String, name_property: true
property :port_index, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/del-port"
    port_index = new_resource.port_index

    params = { "del-port": {"port-index": port_index,} }

    params[:"del-port"].each do |k, v|
        if not v 
            params[:"del-port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating del-port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/del-port"
    port_index = new_resource.port_index

    params = { "del-port": {"port-index": port_index,} }

    params[:"del-port"].each do |k, v|
        if not v
            params[:"del-port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["del-port"].each do |k, v|
        if v != params[:"del-port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating del-port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/del-port"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting del-port') do
            client.delete(url)
        end
    end
end