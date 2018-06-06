resource_name :a10_file_license

property :a10_name, String, name_property: true
property :dst_file, String
property :device, Integer
property :file, String
property :a10_action, ['create','import','export','copy','rename','check','replace','delete']
property :file_handle, String
property :size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/license"
    dst_file = new_resource.dst_file
    device = new_resource.device
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "license": {"dst-file": dst_file,
        "device": device,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"license"].each do |k, v|
        if not v 
            params[:"license"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating license') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/license"
    dst_file = new_resource.dst_file
    device = new_resource.device
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "license": {"dst-file": dst_file,
        "device": device,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"license"].each do |k, v|
        if not v
            params[:"license"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["license"].each do |k, v|
        if v != params[:"license"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating license') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/license"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting license') do
            client.delete(url)
        end
    end
end