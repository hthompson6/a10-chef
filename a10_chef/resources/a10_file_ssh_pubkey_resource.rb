resource_name :a10_file_ssh_pubkey

property :a10_name, String, name_property: true
property :user, String
property :file_handle, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/ssh-pubkey"
    user = new_resource.user
    file_handle = new_resource.file_handle

    params = { "ssh-pubkey": {"user": user,
        "file-handle": file_handle,} }

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
    url = "/axapi/v3/file/ssh-pubkey"
    user = new_resource.user
    file_handle = new_resource.file_handle

    params = { "ssh-pubkey": {"user": user,
        "file-handle": file_handle,} }

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
    url = "/axapi/v3/file/ssh-pubkey"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssh-pubkey') do
            client.delete(url)
        end
    end
end