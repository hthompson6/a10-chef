resource_name :a10_web_service

property :a10_name, String, name_property: true
property :login_message, String
property :axapi_session_limit, Integer
property :secure, Hash
property :axapi_idle, Integer
property :server_disable, [true, false]
property :secure_port, Integer
property :auto_redirt_disable, [true, false]
property :secure_server_disable, [true, false]
property :port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/web-service"
    login_message = new_resource.login_message
    axapi_session_limit = new_resource.axapi_session_limit
    secure = new_resource.secure
    axapi_idle = new_resource.axapi_idle
    server_disable = new_resource.server_disable
    secure_port = new_resource.secure_port
    auto_redirt_disable = new_resource.auto_redirt_disable
    secure_server_disable = new_resource.secure_server_disable
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "web-service": {"login-message": login_message,
        "axapi-session-limit": axapi_session_limit,
        "secure": secure,
        "axapi-idle": axapi_idle,
        "server-disable": server_disable,
        "secure-port": secure_port,
        "auto-redirt-disable": auto_redirt_disable,
        "secure-server-disable": secure_server_disable,
        "port": port,
        "uuid": uuid,} }

    params[:"web-service"].each do |k, v|
        if not v 
            params[:"web-service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating web-service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service"
    login_message = new_resource.login_message
    axapi_session_limit = new_resource.axapi_session_limit
    secure = new_resource.secure
    axapi_idle = new_resource.axapi_idle
    server_disable = new_resource.server_disable
    secure_port = new_resource.secure_port
    auto_redirt_disable = new_resource.auto_redirt_disable
    secure_server_disable = new_resource.secure_server_disable
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "web-service": {"login-message": login_message,
        "axapi-session-limit": axapi_session_limit,
        "secure": secure,
        "axapi-idle": axapi_idle,
        "server-disable": server_disable,
        "secure-port": secure_port,
        "auto-redirt-disable": auto_redirt_disable,
        "secure-server-disable": secure_server_disable,
        "port": port,
        "uuid": uuid,} }

    params[:"web-service"].each do |k, v|
        if not v
            params[:"web-service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["web-service"].each do |k, v|
        if v != params[:"web-service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating web-service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting web-service') do
            client.delete(url)
        end
    end
end