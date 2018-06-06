resource_name :a10_acos_events_collector_group_log_server

property :a10_name, String, name_property: true
property :port, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/collector-group/%<name>s/log-server/"
    get_url = "/axapi/v3/acos-events/collector-group/%<name>s/log-server/%<name>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name

    params = { "log-server": {"port": port,
        "uuid": uuid,
        "name": a10_name,} }

    params[:"log-server"].each do |k, v|
        if not v 
            params[:"log-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/collector-group/%<name>s/log-server/%<name>s+%<port>s"
    port = new_resource.port
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name

    params = { "log-server": {"port": port,
        "uuid": uuid,
        "name": a10_name,} }

    params[:"log-server"].each do |k, v|
        if not v
            params[:"log-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log-server"].each do |k, v|
        if v != params[:"log-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/collector-group/%<name>s/log-server/%<name>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log-server') do
            client.delete(url)
        end
    end
end