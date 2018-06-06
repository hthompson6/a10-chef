resource_name :a10_glm

property :a10_name, String, name_property: true
property :uuid, String
property :use_mgmt_port, [true, false]
property :interval, Integer
property :a10_send, Hash
property :token, String
property :enterprise, String
property :proxy_server, Hash
property :appliance_name, String
property :enable_requests, [true, false]
property :allocate_bandwidth, Integer
property :port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/glm"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    interval = new_resource.interval
    a10_name = new_resource.a10_name
    token = new_resource.token
    enterprise = new_resource.enterprise
    proxy_server = new_resource.proxy_server
    appliance_name = new_resource.appliance_name
    enable_requests = new_resource.enable_requests
    allocate_bandwidth = new_resource.allocate_bandwidth
    port = new_resource.port

    params = { "glm": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "interval": interval,
        "send": a10_send,
        "token": token,
        "enterprise": enterprise,
        "proxy-server": proxy_server,
        "appliance-name": appliance_name,
        "enable-requests": enable_requests,
        "allocate-bandwidth": allocate_bandwidth,
        "port": port,} }

    params[:"glm"].each do |k, v|
        if not v 
            params[:"glm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating glm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glm"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    interval = new_resource.interval
    a10_name = new_resource.a10_name
    token = new_resource.token
    enterprise = new_resource.enterprise
    proxy_server = new_resource.proxy_server
    appliance_name = new_resource.appliance_name
    enable_requests = new_resource.enable_requests
    allocate_bandwidth = new_resource.allocate_bandwidth
    port = new_resource.port

    params = { "glm": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "interval": interval,
        "send": a10_send,
        "token": token,
        "enterprise": enterprise,
        "proxy-server": proxy_server,
        "appliance-name": appliance_name,
        "enable-requests": enable_requests,
        "allocate-bandwidth": allocate_bandwidth,
        "port": port,} }

    params[:"glm"].each do |k, v|
        if not v
            params[:"glm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["glm"].each do |k, v|
        if v != params[:"glm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating glm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glm"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting glm') do
            client.delete(url)
        end
    end
end