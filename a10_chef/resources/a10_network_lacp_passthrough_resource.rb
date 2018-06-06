resource_name :a10_network_lacp_passthrough

property :a10_name, String, name_property: true
property :peer_from, String,required: true
property :peer_to, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/lacp-passthrough/"
    get_url = "/axapi/v3/network/lacp-passthrough/%<peer-from>s+%<peer-to>s"
    peer_from = new_resource.peer_from
    peer_to = new_resource.peer_to
    uuid = new_resource.uuid

    params = { "lacp-passthrough": {"peer-from": peer_from,
        "peer-to": peer_to,
        "uuid": uuid,} }

    params[:"lacp-passthrough"].each do |k, v|
        if not v 
            params[:"lacp-passthrough"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lacp-passthrough') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lacp-passthrough/%<peer-from>s+%<peer-to>s"
    peer_from = new_resource.peer_from
    peer_to = new_resource.peer_to
    uuid = new_resource.uuid

    params = { "lacp-passthrough": {"peer-from": peer_from,
        "peer-to": peer_to,
        "uuid": uuid,} }

    params[:"lacp-passthrough"].each do |k, v|
        if not v
            params[:"lacp-passthrough"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lacp-passthrough"].each do |k, v|
        if v != params[:"lacp-passthrough"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lacp-passthrough') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lacp-passthrough/%<peer-from>s+%<peer-to>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lacp-passthrough') do
            client.delete(url)
        end
    end
end