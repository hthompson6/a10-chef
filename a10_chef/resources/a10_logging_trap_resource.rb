resource_name :a10_logging_trap

property :a10_name, String, name_property: true
property :uuid, String
property :trap_levelname, ['disable','emergency','alert','critical']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/trap"
    uuid = new_resource.uuid
    trap_levelname = new_resource.trap_levelname

    params = { "trap": {"uuid": uuid,
        "trap-levelname": trap_levelname,} }

    params[:"trap"].each do |k, v|
        if not v 
            params[:"trap"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trap') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/trap"
    uuid = new_resource.uuid
    trap_levelname = new_resource.trap_levelname

    params = { "trap": {"uuid": uuid,
        "trap-levelname": trap_levelname,} }

    params[:"trap"].each do |k, v|
        if not v
            params[:"trap"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trap"].each do |k, v|
        if v != params[:"trap"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trap') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/trap"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trap') do
            client.delete(url)
        end
    end
end