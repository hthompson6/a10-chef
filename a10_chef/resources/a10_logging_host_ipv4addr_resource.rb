resource_name :a10_logging_host_ipv4addr

property :a10_name, String, name_property: true
property :host_ipv4, String,required: true
property :use_mgmt_port, [true, false]
property :port, Integer
property :tcp, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/host/ipv4addr/"
    get_url = "/axapi/v3/logging/host/ipv4addr/%<host-ipv4>s"
    host_ipv4 = new_resource.host_ipv4
    use_mgmt_port = new_resource.use_mgmt_port
    port = new_resource.port
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "ipv4addr": {"host-ipv4": host_ipv4,
        "use-mgmt-port": use_mgmt_port,
        "port": port,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"ipv4addr"].each do |k, v|
        if not v 
            params[:"ipv4addr"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4addr') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/host/ipv4addr/%<host-ipv4>s"
    host_ipv4 = new_resource.host_ipv4
    use_mgmt_port = new_resource.use_mgmt_port
    port = new_resource.port
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "ipv4addr": {"host-ipv4": host_ipv4,
        "use-mgmt-port": use_mgmt_port,
        "port": port,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"ipv4addr"].each do |k, v|
        if not v
            params[:"ipv4addr"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4addr"].each do |k, v|
        if v != params[:"ipv4addr"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4addr') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/host/ipv4addr/%<host-ipv4>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4addr') do
            client.delete(url)
        end
    end
end