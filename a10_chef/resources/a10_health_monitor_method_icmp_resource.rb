resource_name :a10_health_monitor_method_icmp

property :a10_name, String, name_property: true
property :ip, String
property :icmp, [true, false]
property :uuid, String
property :ipv6, String
property :transparent, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/icmp"
    ip = new_resource.ip
    icmp = new_resource.icmp
    uuid = new_resource.uuid
    ipv6 = new_resource.ipv6
    transparent = new_resource.transparent

    params = { "icmp": {"ip": ip,
        "icmp": icmp,
        "uuid": uuid,
        "ipv6": ipv6,
        "transparent": transparent,} }

    params[:"icmp"].each do |k, v|
        if not v 
            params[:"icmp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating icmp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/icmp"
    ip = new_resource.ip
    icmp = new_resource.icmp
    uuid = new_resource.uuid
    ipv6 = new_resource.ipv6
    transparent = new_resource.transparent

    params = { "icmp": {"ip": ip,
        "icmp": icmp,
        "uuid": uuid,
        "ipv6": ipv6,
        "transparent": transparent,} }

    params[:"icmp"].each do |k, v|
        if not v
            params[:"icmp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["icmp"].each do |k, v|
        if v != params[:"icmp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating icmp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/icmp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting icmp') do
            client.delete(url)
        end
    end
end