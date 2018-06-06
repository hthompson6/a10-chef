resource_name :a10_enable_core

property :a10_name, String, name_property: true
property :uuid, String
property :core_level, ['a10','system']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/enable-core"
    uuid = new_resource.uuid
    core_level = new_resource.core_level

    params = { "enable-core": {"uuid": uuid,
        "core-level": core_level,} }

    params[:"enable-core"].each do |k, v|
        if not v 
            params[:"enable-core"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating enable-core') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-core"
    uuid = new_resource.uuid
    core_level = new_resource.core_level

    params = { "enable-core": {"uuid": uuid,
        "core-level": core_level,} }

    params[:"enable-core"].each do |k, v|
        if not v
            params[:"enable-core"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["enable-core"].each do |k, v|
        if v != params[:"enable-core"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating enable-core') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-core"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting enable-core') do
            client.delete(url)
        end
    end
end