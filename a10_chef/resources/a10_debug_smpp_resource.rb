resource_name :a10_debug_smpp

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/smpp"
    uuid = new_resource.uuid

    params = { "smpp": {"uuid": uuid,} }

    params[:"smpp"].each do |k, v|
        if not v 
            params[:"smpp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating smpp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/smpp"
    uuid = new_resource.uuid

    params = { "smpp": {"uuid": uuid,} }

    params[:"smpp"].each do |k, v|
        if not v
            params[:"smpp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["smpp"].each do |k, v|
        if v != params[:"smpp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating smpp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/smpp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting smpp') do
            client.delete(url)
        end
    end
end