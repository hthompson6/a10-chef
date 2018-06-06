resource_name :a10_pki_copy_key

property :a10_name, String, name_property: true
property :rotation, Integer
property :dest_key, String
property :overwrite, [true, false]
property :src_key, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/pki/"
    get_url = "/axapi/v3/pki/copy-key"
    rotation = new_resource.rotation
    dest_key = new_resource.dest_key
    overwrite = new_resource.overwrite
    src_key = new_resource.src_key

    params = { "copy-key": {"rotation": rotation,
        "dest-key": dest_key,
        "overwrite": overwrite,
        "src-key": src_key,} }

    params[:"copy-key"].each do |k, v|
        if not v 
            params[:"copy-key"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating copy-key') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/copy-key"
    rotation = new_resource.rotation
    dest_key = new_resource.dest_key
    overwrite = new_resource.overwrite
    src_key = new_resource.src_key

    params = { "copy-key": {"rotation": rotation,
        "dest-key": dest_key,
        "overwrite": overwrite,
        "src-key": src_key,} }

    params[:"copy-key"].each do |k, v|
        if not v
            params[:"copy-key"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["copy-key"].each do |k, v|
        if v != params[:"copy-key"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating copy-key') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/copy-key"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting copy-key') do
            client.delete(url)
        end
    end
end