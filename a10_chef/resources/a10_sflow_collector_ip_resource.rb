resource_name :a10_sflow_collector_ip

property :a10_name, String, name_property: true
property :port, Integer,required: true
property :uuid, String
property :addr, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sflow/collector/ip/"
    get_url = "/axapi/v3/sflow/collector/ip/%<addr>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    addr = new_resource.addr

    params = { "ip": {"port": port,
        "uuid": uuid,
        "addr": addr,} }

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
    url = "/axapi/v3/sflow/collector/ip/%<addr>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    addr = new_resource.addr

    params = { "ip": {"port": port,
        "uuid": uuid,
        "addr": addr,} }

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
    url = "/axapi/v3/sflow/collector/ip/%<addr>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end