resource_name :a10_file_ssl_cert

property :a10_name, String, name_property: true
property :pfx_password, String
property :dst_file, String
property :file, String
property :a10_action, ['create','import','export','copy','rename','check','replace','delete']
property :certificate_type, ['pem','der','pfx','p7b']
property :file_handle, String
property :size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/ssl-cert"
    pfx_password = new_resource.pfx_password
    dst_file = new_resource.dst_file
    file = new_resource.file
    a10_name = new_resource.a10_name
    certificate_type = new_resource.certificate_type
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "ssl-cert": {"pfx-password": pfx_password,
        "dst-file": dst_file,
        "file": file,
        "action": a10_action,
        "certificate-type": certificate_type,
        "file-handle": file_handle,
        "size": size,} }

    params[:"ssl-cert"].each do |k, v|
        if not v 
            params[:"ssl-cert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssl-cert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/ssl-cert"
    pfx_password = new_resource.pfx_password
    dst_file = new_resource.dst_file
    file = new_resource.file
    a10_name = new_resource.a10_name
    certificate_type = new_resource.certificate_type
    file_handle = new_resource.file_handle
    size = new_resource.size

    params = { "ssl-cert": {"pfx-password": pfx_password,
        "dst-file": dst_file,
        "file": file,
        "action": a10_action,
        "certificate-type": certificate_type,
        "file-handle": file_handle,
        "size": size,} }

    params[:"ssl-cert"].each do |k, v|
        if not v
            params[:"ssl-cert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssl-cert"].each do |k, v|
        if v != params[:"ssl-cert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssl-cert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/ssl-cert"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssl-cert') do
            client.delete(url)
        end
    end
end