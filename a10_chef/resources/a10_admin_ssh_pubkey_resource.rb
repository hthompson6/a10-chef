resource_name :a10_admin_ssh_pubkey

property :a10_name, String, name_property: true
property :nimport, [true, false]
property :list, [true, false]
property :use_mgmt_port, [true, false]
property :file_url, String
property :delete, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/admin/%<user>s/"
    get_url = "/axapi/v3/admin/%<user>s/ssh-pubkey"
    nimport = new_resource.nimport
    list = new_resource.list
    use_mgmt_port = new_resource.use_mgmt_port
    file_url = new_resource.file_url
    delete = new_resource.delete

    params = { "ssh-pubkey": {"import": nimport,
        "list": list,
        "use-mgmt-port": use_mgmt_port,
        "file-url": file_url,
        "delete": delete,} }

    params[:"ssh-pubkey"].each do |k, v|
        if not v 
            params[:"ssh-pubkey"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssh-pubkey') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/ssh-pubkey"
    nimport = new_resource.nimport
    list = new_resource.list
    use_mgmt_port = new_resource.use_mgmt_port
    file_url = new_resource.file_url
    delete = new_resource.delete

    params = { "ssh-pubkey": {"import": nimport,
        "list": list,
        "use-mgmt-port": use_mgmt_port,
        "file-url": file_url,
        "delete": delete,} }

    params[:"ssh-pubkey"].each do |k, v|
        if not v
            params[:"ssh-pubkey"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssh-pubkey"].each do |k, v|
        if v != params[:"ssh-pubkey"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssh-pubkey') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/ssh-pubkey"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssh-pubkey') do
            client.delete(url)
        end
    end
end