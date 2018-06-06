resource_name :a10_radius_server_host_ipv6

property :a10_name, String, name_property: true
property :secret, Hash
property :ipv6_addr, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/radius-server/host/ipv6/"
    get_url = "/axapi/v3/radius-server/host/ipv6/%<ipv6-addr>s"
    secret = new_resource.secret
    ipv6_addr = new_resource.ipv6_addr
    uuid = new_resource.uuid

    params = { "ipv6": {"secret": secret,
        "ipv6-addr": ipv6_addr,
        "uuid": uuid,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server/host/ipv6/%<ipv6-addr>s"
    secret = new_resource.secret
    ipv6_addr = new_resource.ipv6_addr
    uuid = new_resource.uuid

    params = { "ipv6": {"secret": secret,
        "ipv6-addr": ipv6_addr,
        "uuid": uuid,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server/host/ipv6/%<ipv6-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end