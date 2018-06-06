resource_name :a10_cgnv6_lsn_health_check_gateway

property :a10_name, String, name_property: true
property :ipv4_addr, String,required: true
property :ipv6_addr, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/health-check-gateway/"
    get_url = "/axapi/v3/cgnv6/lsn/health-check-gateway/%<ipv4-addr>s+%<ipv6-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    ipv6_addr = new_resource.ipv6_addr
    uuid = new_resource.uuid

    params = { "health-check-gateway": {"ipv4-addr": ipv4_addr,
        "ipv6-addr": ipv6_addr,
        "uuid": uuid,} }

    params[:"health-check-gateway"].each do |k, v|
        if not v 
            params[:"health-check-gateway"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating health-check-gateway') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/health-check-gateway/%<ipv4-addr>s+%<ipv6-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    ipv6_addr = new_resource.ipv6_addr
    uuid = new_resource.uuid

    params = { "health-check-gateway": {"ipv4-addr": ipv4_addr,
        "ipv6-addr": ipv6_addr,
        "uuid": uuid,} }

    params[:"health-check-gateway"].each do |k, v|
        if not v
            params[:"health-check-gateway"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["health-check-gateway"].each do |k, v|
        if v != params[:"health-check-gateway"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating health-check-gateway') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/health-check-gateway/%<ipv4-addr>s+%<ipv6-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-check-gateway') do
            client.delete(url)
        end
    end
end