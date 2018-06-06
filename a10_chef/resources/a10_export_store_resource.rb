resource_name :a10_export_store

property :a10_name, String, name_property: true
property :create, [true, false]
property :remote_file, String
property :delete, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/export/"
    get_url = "/axapi/v3/export/store"
    create = new_resource.create
    a10_name = new_resource.a10_name
    remote_file = new_resource.remote_file
    delete = new_resource.delete

    params = { "store": {"create": create,
        "name": a10_name,
        "remote-file": remote_file,
        "delete": delete,} }

    params[:"store"].each do |k, v|
        if not v 
            params[:"store"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating store') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/export/store"
    create = new_resource.create
    a10_name = new_resource.a10_name
    remote_file = new_resource.remote_file
    delete = new_resource.delete

    params = { "store": {"create": create,
        "name": a10_name,
        "remote-file": remote_file,
        "delete": delete,} }

    params[:"store"].each do |k, v|
        if not v
            params[:"store"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["store"].each do |k, v|
        if v != params[:"store"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating store') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/export/store"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting store') do
            client.delete(url)
        end
    end
end