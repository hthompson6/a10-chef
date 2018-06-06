resource_name :a10_debug_ospf_packet

property :a10_name, String, name_property: true
property :uuid, String
property :ls_request, [true, false]
property :dd, [true, false]
property :detail, [true, false]
property :a10_send, [true, false]
property :ls_ack, [true, false]
property :ls_update, [true, false]
property :recv, [true, false]
property :hello, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ospf/"
    get_url = "/axapi/v3/debug/ospf/packet"
    uuid = new_resource.uuid
    ls_request = new_resource.ls_request
    dd = new_resource.dd
    detail = new_resource.detail
    a10_name = new_resource.a10_name
    ls_ack = new_resource.ls_ack
    ls_update = new_resource.ls_update
    recv = new_resource.recv
    hello = new_resource.hello

    params = { "packet": {"uuid": uuid,
        "ls-request": ls_request,
        "dd": dd,
        "detail": detail,
        "send": a10_send,
        "ls-ack": ls_ack,
        "ls-update": ls_update,
        "recv": recv,
        "hello": hello,} }

    params[:"packet"].each do |k, v|
        if not v 
            params[:"packet"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating packet') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/packet"
    uuid = new_resource.uuid
    ls_request = new_resource.ls_request
    dd = new_resource.dd
    detail = new_resource.detail
    a10_name = new_resource.a10_name
    ls_ack = new_resource.ls_ack
    ls_update = new_resource.ls_update
    recv = new_resource.recv
    hello = new_resource.hello

    params = { "packet": {"uuid": uuid,
        "ls-request": ls_request,
        "dd": dd,
        "detail": detail,
        "send": a10_send,
        "ls-ack": ls_ack,
        "ls-update": ls_update,
        "recv": recv,
        "hello": hello,} }

    params[:"packet"].each do |k, v|
        if not v
            params[:"packet"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["packet"].each do |k, v|
        if v != params[:"packet"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating packet') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/packet"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting packet') do
            client.delete(url)
        end
    end
end