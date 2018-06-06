resource_name :a10_file_class_list

property :a10_name, String, name_property: true
property :dst_file, String
property :user_tag, String
property :file, String
property :a10_action, ['ceate','import','export','copy','rename','check','replace','delete']
property :file_handle, String
property :size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/class-list"
    dst_file = new_resource.dst_file
    user_tag = new_resource.user_tag
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "class-list": {"dst-file": dst_file,
        "user-tag": user_tag,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"class-list"].each do |k, v|
        if not v 
            params[:"class-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating class-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/class-list"
    dst_file = new_resource.dst_file
    user_tag = new_resource.user_tag
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "class-list": {"dst-file": dst_file,
        "user-tag": user_tag,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"class-list"].each do |k, v|
        if not v
            params[:"class-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["class-list"].each do |k, v|
        if v != params[:"class-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating class-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/class-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list') do
            client.delete(url)
        end
    end
end