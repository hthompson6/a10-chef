resource_name :a10_backup_system

property :a10_name, String, name_property: true
property :password, String
property :use_mgmt_port, [true, false]
property :remote_file, String
property :store_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/backup/"
    get_url = "/axapi/v3/backup/system"
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    store_name = new_resource.store_name

    params = { "system": {"password": password,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "store-name": store_name,} }

    params[:"system"].each do |k, v|
        if not v 
            params[:"system"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/system"
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    store_name = new_resource.store_name

    params = { "system": {"password": password,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "store-name": store_name,} }

    params[:"system"].each do |k, v|
        if not v
            params[:"system"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system"].each do |k, v|
        if v != params[:"system"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/system"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system') do
            client.delete(url)
        end
    end
end