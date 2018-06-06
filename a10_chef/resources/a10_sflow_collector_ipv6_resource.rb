resource_name :a10_sflow_collector_ipv6

property :a10_name, String, name_property: true
property :port, Integer,required: true
property :uuid, String
property :addr, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sflow/collector/ipv6/"
    get_url = "/axapi/v3/sflow/collector/ipv6/%<addr>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    addr = new_resource.addr

    params = { "ipv6": {"port": port,
        "uuid": uuid,
        "addr": addr,} }

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
    url = "/axapi/v3/sflow/collector/ipv6/%<addr>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    addr = new_resource.addr

    params = { "ipv6": {"port": port,
        "uuid": uuid,
        "addr": addr,} }

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
    url = "/axapi/v3/sflow/collector/ipv6/%<addr>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end