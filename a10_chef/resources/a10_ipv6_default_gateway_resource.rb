resource_name :a10_ipv6_default_gateway

property :a10_name, String, name_property: true
property :ipv6_default_gateway, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/"
    get_url = "/axapi/v3/ipv6/default-gateway"
    ipv6_default_gateway = new_resource.ipv6_default_gateway
    uuid = new_resource.uuid

    params = { "default-gateway": {"ipv6-default-gateway": ipv6_default_gateway,
        "uuid": uuid,} }

    params[:"default-gateway"].each do |k, v|
        if not v 
            params[:"default-gateway"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating default-gateway') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/default-gateway"
    ipv6_default_gateway = new_resource.ipv6_default_gateway
    uuid = new_resource.uuid

    params = { "default-gateway": {"ipv6-default-gateway": ipv6_default_gateway,
        "uuid": uuid,} }

    params[:"default-gateway"].each do |k, v|
        if not v
            params[:"default-gateway"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["default-gateway"].each do |k, v|
        if v != params[:"default-gateway"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating default-gateway') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/default-gateway"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default-gateway') do
            client.delete(url)
        end
    end
end