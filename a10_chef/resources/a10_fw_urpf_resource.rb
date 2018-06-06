resource_name :a10_fw_urpf

property :a10_name, String, name_property: true
property :status, ['strict']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/urpf"
    status = new_resource.status
    uuid = new_resource.uuid

    params = { "urpf": {"status": status,
        "uuid": uuid,} }

    params[:"urpf"].each do |k, v|
        if not v 
            params[:"urpf"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating urpf') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/urpf"
    status = new_resource.status
    uuid = new_resource.uuid

    params = { "urpf": {"status": status,
        "uuid": uuid,} }

    params[:"urpf"].each do |k, v|
        if not v
            params[:"urpf"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["urpf"].each do |k, v|
        if v != params[:"urpf"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating urpf') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/urpf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting urpf') do
            client.delete(url)
        end
    end
end