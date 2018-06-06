resource_name :a10_import_to_device

property :a10_name, String, name_property: true
property :web_category_license, String
property :remote_file, String
property :glm_license, String
property :glm_cert, String
property :device, Integer
property :use_mgmt_port, [true, false]
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import/"
    get_url = "/axapi/v3/import/to-device"
    web_category_license = new_resource.web_category_license
    remote_file = new_resource.remote_file
    glm_license = new_resource.glm_license
    glm_cert = new_resource.glm_cert
    device = new_resource.device
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "to-device": {"web-category-license": web_category_license,
        "remote-file": remote_file,
        "glm-license": glm_license,
        "glm-cert": glm_cert,
        "device": device,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

    params[:"to-device"].each do |k, v|
        if not v 
            params[:"to-device"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating to-device') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import/to-device"
    web_category_license = new_resource.web_category_license
    remote_file = new_resource.remote_file
    glm_license = new_resource.glm_license
    glm_cert = new_resource.glm_cert
    device = new_resource.device
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "to-device": {"web-category-license": web_category_license,
        "remote-file": remote_file,
        "glm-license": glm_license,
        "glm-cert": glm_cert,
        "device": device,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

    params[:"to-device"].each do |k, v|
        if not v
            params[:"to-device"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["to-device"].each do |k, v|
        if v != params[:"to-device"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating to-device') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import/to-device"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting to-device') do
            client.delete(url)
        end
    end
end