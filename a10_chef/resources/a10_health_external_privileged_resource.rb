resource_name :a10_health_external_privileged

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/external/"
    get_url = "/axapi/v3/health/external/privileged"
    a10_name = new_resource.a10_name

    params = { "privileged": {"action": a10_action,} }

    params[:"privileged"].each do |k, v|
        if not v 
            params[:"privileged"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating privileged') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/external/privileged"
    a10_name = new_resource.a10_name

    params = { "privileged": {"action": a10_action,} }

    params[:"privileged"].each do |k, v|
        if not v
            params[:"privileged"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["privileged"].each do |k, v|
        if v != params[:"privileged"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating privileged') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/external/privileged"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting privileged') do
            client.delete(url)
        end
    end
end