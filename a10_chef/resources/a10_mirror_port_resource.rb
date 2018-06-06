resource_name :a10_mirror_port

property :a10_name, String, name_property: true
property :ethernet, String
property :uuid, String
property :mirror_index, Integer,required: true
property :mirror_dir, ['input','output','both']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/mirror-port/"
    get_url = "/axapi/v3/mirror-port/%<mirror-index>s"
    ethernet = new_resource.ethernet
    uuid = new_resource.uuid
    mirror_index = new_resource.mirror_index
    mirror_dir = new_resource.mirror_dir

    params = { "mirror-port": {"ethernet": ethernet,
        "uuid": uuid,
        "mirror-index": mirror_index,
        "mirror-dir": mirror_dir,} }

    params[:"mirror-port"].each do |k, v|
        if not v 
            params[:"mirror-port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mirror-port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/mirror-port/%<mirror-index>s"
    ethernet = new_resource.ethernet
    uuid = new_resource.uuid
    mirror_index = new_resource.mirror_index
    mirror_dir = new_resource.mirror_dir

    params = { "mirror-port": {"ethernet": ethernet,
        "uuid": uuid,
        "mirror-index": mirror_index,
        "mirror-dir": mirror_dir,} }

    params[:"mirror-port"].each do |k, v|
        if not v
            params[:"mirror-port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mirror-port"].each do |k, v|
        if v != params[:"mirror-port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mirror-port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/mirror-port/%<mirror-index>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mirror-port') do
            client.delete(url)
        end
    end
end