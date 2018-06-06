resource_name :a10_web_service_secure_private_key

property :a10_name, String, name_property: true
property :load, [true, false]
property :use_mgmt_port, [true, false]
property :file_url, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/web-service/secure/"
    get_url = "/axapi/v3/web-service/secure/private-key"
    load = new_resource.load
    use_mgmt_port = new_resource.use_mgmt_port
    file_url = new_resource.file_url

    params = { "private-key": {"load": load,
        "use-mgmt-port": use_mgmt_port,
        "file-url": file_url,} }

    params[:"private-key"].each do |k, v|
        if not v 
            params[:"private-key"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating private-key') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure/private-key"
    load = new_resource.load
    use_mgmt_port = new_resource.use_mgmt_port
    file_url = new_resource.file_url

    params = { "private-key": {"load": load,
        "use-mgmt-port": use_mgmt_port,
        "file-url": file_url,} }

    params[:"private-key"].each do |k, v|
        if not v
            params[:"private-key"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["private-key"].each do |k, v|
        if v != params[:"private-key"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating private-key') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure/private-key"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting private-key') do
            client.delete(url)
        end
    end
end