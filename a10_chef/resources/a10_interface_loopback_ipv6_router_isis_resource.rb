resource_name :a10_interface_loopback_ipv6_router_isis

property :a10_name, String, name_property: true
property :tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/loopback/%<ifnum>s/ipv6/router/"
    get_url = "/axapi/v3/interface/loopback/%<ifnum>s/ipv6/router/isis"
    tag = new_resource.tag
    uuid = new_resource.uuid

    params = { "isis": {"tag": tag,
        "uuid": uuid,} }

    params[:"isis"].each do |k, v|
        if not v 
            params[:"isis"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating isis') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s/ipv6/router/isis"
    tag = new_resource.tag
    uuid = new_resource.uuid

    params = { "isis": {"tag": tag,
        "uuid": uuid,} }

    params[:"isis"].each do |k, v|
        if not v
            params[:"isis"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["isis"].each do |k, v|
        if v != params[:"isis"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating isis') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s/ipv6/router/isis"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting isis') do
            client.delete(url)
        end
    end
end