resource_name :a10_debug_ssli

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/ssli"
    uuid = new_resource.uuid

    params = { "ssli": {"uuid": uuid,} }

    params[:"ssli"].each do |k, v|
        if not v 
            params[:"ssli"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssli') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ssli"
    uuid = new_resource.uuid

    params = { "ssli": {"uuid": uuid,} }

    params[:"ssli"].each do |k, v|
        if not v
            params[:"ssli"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssli"].each do |k, v|
        if v != params[:"ssli"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssli') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ssli"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssli') do
            client.delete(url)
        end
    end
end