resource_name :a10_restore

property :a10_name, String, name_property: true
property :use_mgmt_port, [true, false]
property :remote_file, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/restore"
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file

    params = { "restore": {"use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,} }

    params[:"restore"].each do |k, v|
        if not v 
            params[:"restore"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating restore') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/restore"
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file

    params = { "restore": {"use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,} }

    params[:"restore"].each do |k, v|
        if not v
            params[:"restore"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["restore"].each do |k, v|
        if v != params[:"restore"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating restore') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/restore"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting restore') do
            client.delete(url)
        end
    end
end