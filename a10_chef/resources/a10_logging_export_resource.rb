resource_name :a10_logging_export

property :a10_name, String, name_property: true
property :all, [true, false]
property :use_mgmt_port, [true, false]
property :remote_file, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/export"
    all = new_resource.all
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file

    params = { "export": {"all": all,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,} }

    params[:"export"].each do |k, v|
        if not v 
            params[:"export"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating export') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/export"
    all = new_resource.all
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file

    params = { "export": {"all": all,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,} }

    params[:"export"].each do |k, v|
        if not v
            params[:"export"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["export"].each do |k, v|
        if v != params[:"export"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating export') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/export"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting export') do
            client.delete(url)
        end
    end
end