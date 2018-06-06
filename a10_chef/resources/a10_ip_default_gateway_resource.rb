resource_name :a10_ip_default_gateway

property :a10_name, String, name_property: true
property :gateway_ip, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/default-gateway"
    gateway_ip = new_resource.gateway_ip
    uuid = new_resource.uuid

    params = { "default-gateway": {"gateway-ip": gateway_ip,
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
    url = "/axapi/v3/ip/default-gateway"
    gateway_ip = new_resource.gateway_ip
    uuid = new_resource.uuid

    params = { "default-gateway": {"gateway-ip": gateway_ip,
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
    url = "/axapi/v3/ip/default-gateway"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default-gateway') do
            client.delete(url)
        end
    end
end