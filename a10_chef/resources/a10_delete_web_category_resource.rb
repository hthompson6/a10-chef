resource_name :a10_delete_web_category

property :a10_name, String, name_property: true
property :database, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/web-category"
    database = new_resource.database

    params = { "web-category": {"database": database,} }

    params[:"web-category"].each do |k, v|
        if not v 
            params[:"web-category"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating web-category') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/web-category"
    database = new_resource.database

    params = { "web-category": {"database": database,} }

    params[:"web-category"].each do |k, v|
        if not v
            params[:"web-category"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["web-category"].each do |k, v|
        if v != params[:"web-category"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating web-category') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/web-category"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting web-category') do
            client.delete(url)
        end
    end
end