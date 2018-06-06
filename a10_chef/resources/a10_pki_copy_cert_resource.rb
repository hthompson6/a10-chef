resource_name :a10_pki_copy_cert

property :a10_name, String, name_property: true
property :rotation, Integer
property :src_cert, String
property :dest_cert, String
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/pki/"
    get_url = "/axapi/v3/pki/copy-cert"
    rotation = new_resource.rotation
    src_cert = new_resource.src_cert
    dest_cert = new_resource.dest_cert
    overwrite = new_resource.overwrite

    params = { "copy-cert": {"rotation": rotation,
        "src-cert": src_cert,
        "dest-cert": dest_cert,
        "overwrite": overwrite,} }

    params[:"copy-cert"].each do |k, v|
        if not v 
            params[:"copy-cert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating copy-cert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/copy-cert"
    rotation = new_resource.rotation
    src_cert = new_resource.src_cert
    dest_cert = new_resource.dest_cert
    overwrite = new_resource.overwrite

    params = { "copy-cert": {"rotation": rotation,
        "src-cert": src_cert,
        "dest-cert": dest_cert,
        "overwrite": overwrite,} }

    params[:"copy-cert"].each do |k, v|
        if not v
            params[:"copy-cert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["copy-cert"].each do |k, v|
        if v != params[:"copy-cert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating copy-cert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/copy-cert"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting copy-cert') do
            client.delete(url)
        end
    end
end