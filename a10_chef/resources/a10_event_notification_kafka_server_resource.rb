resource_name :a10_event_notification_kafka_server

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :host_ipv4, String
property :port, Integer
property :use_mgmt_port, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/event-notification/kafka/"
    get_url = "/axapi/v3/event-notification/kafka/server"
    sampling_enable = new_resource.sampling_enable
    host_ipv4 = new_resource.host_ipv4
    port = new_resource.port
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid

    params = { "server": {"sampling-enable": sampling_enable,
        "host-ipv4": host_ipv4,
        "port": port,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,} }

    params[:"server"].each do |k, v|
        if not v 
            params[:"server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/event-notification/kafka/server"
    sampling_enable = new_resource.sampling_enable
    host_ipv4 = new_resource.host_ipv4
    port = new_resource.port
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid

    params = { "server": {"sampling-enable": sampling_enable,
        "host-ipv4": host_ipv4,
        "port": port,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,} }

    params[:"server"].each do |k, v|
        if not v
            params[:"server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["server"].each do |k, v|
        if v != params[:"server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/event-notification/kafka/server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server') do
            client.delete(url)
        end
    end
end