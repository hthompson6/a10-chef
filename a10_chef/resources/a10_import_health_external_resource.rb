resource_name :a10_import_health_external

property :a10_name, String, name_property: true
property :description, String
property :remote_file, String
property :externalfilename, String
property :password, String
property :use_mgmt_port, [true, false]
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import/"
    get_url = "/axapi/v3/import/health-external"
    description = new_resource.description
    remote_file = new_resource.remote_file
    externalfilename = new_resource.externalfilename
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "health-external": {"description": description,
        "remote-file": remote_file,
        "externalfilename": externalfilename,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

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
    url = "/axapi/v3/import/health-external"
    description = new_resource.description
    remote_file = new_resource.remote_file
    externalfilename = new_resource.externalfilename
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "health-external": {"description": description,
        "remote-file": remote_file,
        "externalfilename": externalfilename,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

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
    url = "/axapi/v3/import/health-external"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-external') do
            client.delete(url)
        end
    end
end