resource_name :a10_debug_generic_proxy

property :a10_name, String, name_property: true
property :uuid, String
property :debug_level, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/generic-proxy"
    uuid = new_resource.uuid
    debug_level = new_resource.debug_level

    params = { "generic-proxy": {"uuid": uuid,
        "debug-level": debug_level,} }

    params[:"generic-proxy"].each do |k, v|
        if not v 
            params[:"generic-proxy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating generic-proxy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/generic-proxy"
    uuid = new_resource.uuid
    debug_level = new_resource.debug_level

    params = { "generic-proxy": {"uuid": uuid,
        "debug-level": debug_level,} }

    params[:"generic-proxy"].each do |k, v|
        if not v
            params[:"generic-proxy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["generic-proxy"].each do |k, v|
        if v != params[:"generic-proxy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating generic-proxy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/generic-proxy"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting generic-proxy') do
            client.delete(url)
        end
    end
end