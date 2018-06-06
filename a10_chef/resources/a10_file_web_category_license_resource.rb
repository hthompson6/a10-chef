resource_name :a10_file_web_category_license

property :a10_name, String, name_property: true
property :use_mgmt_port, [true, false]
property :device, Integer
property :file, String
property :a10_action, ['import']
property :file_handle, String
property :size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/web-category-license"
    use_mgmt_port = new_resource.use_mgmt_port
    device = new_resource.device
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "web-category-license": {"use-mgmt-port": use_mgmt_port,
        "device": device,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"web-category-license"].each do |k, v|
        if not v 
            params[:"web-category-license"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating web-category-license') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/web-category-license"
    use_mgmt_port = new_resource.use_mgmt_port
    device = new_resource.device
    file = new_resource.file
    a10_name = new_resource.a10_name
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "web-category-license": {"use-mgmt-port": use_mgmt_port,
        "device": device,
        "file": file,
        "action": a10_action,
        "file-handle": file_handle,
        "size": size,} }

    params[:"web-category-license"].each do |k, v|
        if not v
            params[:"web-category-license"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["web-category-license"].each do |k, v|
        if v != params[:"web-category-license"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating web-category-license') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/web-category-license"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting web-category-license') do
            client.delete(url)
        end
    end
end