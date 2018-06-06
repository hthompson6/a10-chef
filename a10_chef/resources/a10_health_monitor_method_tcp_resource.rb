resource_name :a10_health_monitor_method_tcp

property :a10_name, String, name_property: true
property :uuid, String
property :tcp_port, Integer
property :port_resp, Hash
property :method_tcp, [true, false]
property :port_send, String
property :port_halfopen, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/tcp"
    uuid = new_resource.uuid
    tcp_port = new_resource.tcp_port
    port_resp = new_resource.port_resp
    method_tcp = new_resource.method_tcp
    port_send = new_resource.port_send
    port_halfopen = new_resource.port_halfopen

    params = { "tcp": {"uuid": uuid,
        "tcp-port": tcp_port,
        "port-resp": port_resp,
        "method-tcp": method_tcp,
        "port-send": port_send,
        "port-halfopen": port_halfopen,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/tcp"
    uuid = new_resource.uuid
    tcp_port = new_resource.tcp_port
    port_resp = new_resource.port_resp
    method_tcp = new_resource.method_tcp
    port_send = new_resource.port_send
    port_halfopen = new_resource.port_halfopen

    params = { "tcp": {"uuid": uuid,
        "tcp-port": tcp_port,
        "port-resp": port_resp,
        "method-tcp": method_tcp,
        "port-send": port_send,
        "port-halfopen": port_halfopen,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/tcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end