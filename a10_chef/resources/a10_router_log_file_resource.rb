resource_name :a10_router_log_file

property :a10_name, String, name_property: true
property :size, Integer
property :rotate, Integer
property :uuid, String
property :per_protocol, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/log/"
    get_url = "/axapi/v3/router/log/file"
    size = new_resource.size
    rotate = new_resource.rotate
    uuid = new_resource.uuid
    per_protocol = new_resource.per_protocol
    a10_name = new_resource.a10_name

    params = { "file": {"size": size,
        "rotate": rotate,
        "uuid": uuid,
        "per-protocol": per_protocol,
        "name": a10_name,} }

    params[:"file"].each do |k, v|
        if not v 
            params[:"file"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating file') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/log/file"
    size = new_resource.size
    rotate = new_resource.rotate
    uuid = new_resource.uuid
    per_protocol = new_resource.per_protocol
    a10_name = new_resource.a10_name

    params = { "file": {"size": size,
        "rotate": rotate,
        "uuid": uuid,
        "per-protocol": per_protocol,
        "name": a10_name,} }

    params[:"file"].each do |k, v|
        if not v
            params[:"file"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["file"].each do |k, v|
        if v != params[:"file"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating file') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/log/file"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting file') do
            client.delete(url)
        end
    end
end