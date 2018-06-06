resource_name :a10_system_ipmi_ip

property :a10_name, String, name_property: true
property :ipv4_address, String
property :default_gateway, String
property :ipv4_netmask, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/ipmi/"
    get_url = "/axapi/v3/system/ipmi/ip"
    ipv4_address = new_resource.ipv4_address
    default_gateway = new_resource.default_gateway
    ipv4_netmask = new_resource.ipv4_netmask

    params = { "ip": {"ipv4-address": ipv4_address,
        "default-gateway": default_gateway,
        "ipv4-netmask": ipv4_netmask,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/ip"
    ipv4_address = new_resource.ipv4_address
    default_gateway = new_resource.default_gateway
    ipv4_netmask = new_resource.ipv4_netmask

    params = { "ip": {"ipv4-address": ipv4_address,
        "default-gateway": default_gateway,
        "ipv4-netmask": ipv4_netmask,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end