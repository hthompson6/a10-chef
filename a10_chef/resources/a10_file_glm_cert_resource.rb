resource_name :a10_file_glm_cert

property :a10_name, String, name_property: true
property :device, Integer
property :a10_action, ['import']
property :dst_file, String
property :file, String
property :file_handle, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/glm-cert"
    device = new_resource.device
    a10_name = new_resource.a10_name
    dst_file = new_resource.dst_file
    file = new_resource.file
    file_handle = new_resource.file_handle

    params = { "glm-cert": {"device": device,
        "action": a10_action,
        "dst-file": dst_file,
        "file": file,
        "file-handle": file_handle,} }

    params[:"glm-cert"].each do |k, v|
        if not v 
            params[:"glm-cert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating glm-cert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/glm-cert"
    device = new_resource.device
    a10_name = new_resource.a10_name
    dst_file = new_resource.dst_file
    file = new_resource.file
    file_handle = new_resource.file_handle

    params = { "glm-cert": {"device": device,
        "action": a10_action,
        "dst-file": dst_file,
        "file": file,
        "file-handle": file_handle,} }

    params[:"glm-cert"].each do |k, v|
        if not v
            params[:"glm-cert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["glm-cert"].each do |k, v|
        if v != params[:"glm-cert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating glm-cert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/glm-cert"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting glm-cert') do
            client.delete(url)
        end
    end
end