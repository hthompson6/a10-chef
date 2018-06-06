resource_name :a10_debug_vector

property :a10_name, String, name_property: true
property :trace, [true, false]
property :uuid, String
property :packet, [true, false]
property :error, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/vector"
    trace = new_resource.trace
    uuid = new_resource.uuid
    packet = new_resource.packet
    error = new_resource.error

    params = { "vector": {"trace": trace,
        "uuid": uuid,
        "packet": packet,
        "error": error,} }

    params[:"vector"].each do |k, v|
        if not v 
            params[:"vector"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vector') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/vector"
    trace = new_resource.trace
    uuid = new_resource.uuid
    packet = new_resource.packet
    error = new_resource.error

    params = { "vector": {"trace": trace,
        "uuid": uuid,
        "packet": packet,
        "error": error,} }

    params[:"vector"].each do |k, v|
        if not v
            params[:"vector"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vector"].each do |k, v|
        if v != params[:"vector"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vector') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/vector"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vector') do
            client.delete(url)
        end
    end
end