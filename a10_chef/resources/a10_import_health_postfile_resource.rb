resource_name :a10_import_health_postfile

property :a10_name, String, name_property: true
property :postfilename, String
property :password, String
property :use_mgmt_port, [true, false]
property :remote_file, String
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import/"
    get_url = "/axapi/v3/import/health-postfile"
    postfilename = new_resource.postfilename
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    overwrite = new_resource.overwrite

    params = { "health-postfile": {"postfilename": postfilename,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "overwrite": overwrite,} }

    params[:"health-postfile"].each do |k, v|
        if not v 
            params[:"health-postfile"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating health-postfile') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import/health-postfile"
    postfilename = new_resource.postfilename
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    overwrite = new_resource.overwrite

    params = { "health-postfile": {"postfilename": postfilename,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "overwrite": overwrite,} }

    params[:"health-postfile"].each do |k, v|
        if not v
            params[:"health-postfile"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["health-postfile"].each do |k, v|
        if v != params[:"health-postfile"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating health-postfile') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import/health-postfile"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-postfile') do
            client.delete(url)
        end
    end
end