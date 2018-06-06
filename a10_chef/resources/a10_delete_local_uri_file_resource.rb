resource_name :a10_delete_local_uri_file

property :a10_name, String, name_property: true
property :file_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/local-uri-file"
    file_name = new_resource.file_name

    params = { "local-uri-file": {"file-name": file_name,} }

    params[:"local-uri-file"].each do |k, v|
        if not v 
            params[:"local-uri-file"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating local-uri-file') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/local-uri-file"
    file_name = new_resource.file_name

    params = { "local-uri-file": {"file-name": file_name,} }

    params[:"local-uri-file"].each do |k, v|
        if not v
            params[:"local-uri-file"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["local-uri-file"].each do |k, v|
        if v != params[:"local-uri-file"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating local-uri-file') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/local-uri-file"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting local-uri-file') do
            client.delete(url)
        end
    end
end