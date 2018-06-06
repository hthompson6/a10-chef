resource_name :a10_debug_msg_proxy

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/msg-proxy"
    uuid = new_resource.uuid

    params = { "msg-proxy": {"uuid": uuid,} }

    params[:"msg-proxy"].each do |k, v|
        if not v 
            params[:"msg-proxy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating msg-proxy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/msg-proxy"
    uuid = new_resource.uuid

    params = { "msg-proxy": {"uuid": uuid,} }

    params[:"msg-proxy"].each do |k, v|
        if not v
            params[:"msg-proxy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["msg-proxy"].each do |k, v|
        if v != params[:"msg-proxy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating msg-proxy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/msg-proxy"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting msg-proxy') do
            client.delete(url)
        end
    end
end