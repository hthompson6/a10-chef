resource_name :a10_delete_health_external

property :a10_name, String, name_property: true
property :file_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/health-external"
    file_name = new_resource.file_name

    params = { "health-external": {"file-name": file_name,} }

    params[:"health-external"].each do |k, v|
        if not v 
            params[:"health-external"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating health-external') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/health-external"
    file_name = new_resource.file_name

    params = { "health-external": {"file-name": file_name,} }

    params[:"health-external"].each do |k, v|
        if not v
            params[:"health-external"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["health-external"].each do |k, v|
        if v != params[:"health-external"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating health-external') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/health-external"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-external') do
            client.delete(url)
        end
    end
end