resource_name :a10_threat_intel_threat_feed

property :a10_name, String, name_property: true
property :domain, String
property :enable, [true, false]
property :uuid, String
property :use_mgmt_port, [true, false]
property :update_interval, Integer
property :server_timeout, Integer
property :proxy_port, Integer
property :proxy_username, String
property :log_level, ['disable','error','warning','info','debug','trace']
property :server, String
property :proxy_host, String
property :proxy_password, [true, false]
property :user_tag, String
property :rtu_update_disable, [true, false]
property :encrypted, String
property :proxy_auth_type, ['ntlm','basic']
property :ntype, ['webroot'],required: true
property :port, Integer
property :secret_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/threat-intel/threat-feed/"
    get_url = "/axapi/v3/threat-intel/threat-feed/%<type>s"
    domain = new_resource.domain
    enable = new_resource.enable
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    update_interval = new_resource.update_interval
    server_timeout = new_resource.server_timeout
    proxy_port = new_resource.proxy_port
    proxy_username = new_resource.proxy_username
    log_level = new_resource.log_level
    server = new_resource.server
    proxy_host = new_resource.proxy_host
    proxy_password = new_resource.proxy_password
    user_tag = new_resource.user_tag
    rtu_update_disable = new_resource.rtu_update_disable
    encrypted = new_resource.encrypted
    proxy_auth_type = new_resource.proxy_auth_type
    ntype = new_resource.ntype
    port = new_resource.port
    secret_string = new_resource.secret_string

    params = { "threat-feed": {"domain": domain,
        "enable": enable,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "update-interval": update_interval,
        "server-timeout": server_timeout,
        "proxy-port": proxy_port,
        "proxy-username": proxy_username,
        "log-level": log_level,
        "server": server,
        "proxy-host": proxy_host,
        "proxy-password": proxy_password,
        "user-tag": user_tag,
        "rtu-update-disable": rtu_update_disable,
        "encrypted": encrypted,
        "proxy-auth-type": proxy_auth_type,
        "type": ntype,
        "port": port,
        "secret-string": secret_string,} }

    params[:"threat-feed"].each do |k, v|
        if not v 
            params[:"threat-feed"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating threat-feed') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/threat-intel/threat-feed/%<type>s"
    domain = new_resource.domain
    enable = new_resource.enable
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    update_interval = new_resource.update_interval
    server_timeout = new_resource.server_timeout
    proxy_port = new_resource.proxy_port
    proxy_username = new_resource.proxy_username
    log_level = new_resource.log_level
    server = new_resource.server
    proxy_host = new_resource.proxy_host
    proxy_password = new_resource.proxy_password
    user_tag = new_resource.user_tag
    rtu_update_disable = new_resource.rtu_update_disable
    encrypted = new_resource.encrypted
    proxy_auth_type = new_resource.proxy_auth_type
    ntype = new_resource.ntype
    port = new_resource.port
    secret_string = new_resource.secret_string

    params = { "threat-feed": {"domain": domain,
        "enable": enable,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "update-interval": update_interval,
        "server-timeout": server_timeout,
        "proxy-port": proxy_port,
        "proxy-username": proxy_username,
        "log-level": log_level,
        "server": server,
        "proxy-host": proxy_host,
        "proxy-password": proxy_password,
        "user-tag": user_tag,
        "rtu-update-disable": rtu_update_disable,
        "encrypted": encrypted,
        "proxy-auth-type": proxy_auth_type,
        "type": ntype,
        "port": port,
        "secret-string": secret_string,} }

    params[:"threat-feed"].each do |k, v|
        if not v
            params[:"threat-feed"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["threat-feed"].each do |k, v|
        if v != params[:"threat-feed"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating threat-feed') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/threat-intel/threat-feed/%<type>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting threat-feed') do
            client.delete(url)
        end
    end
end