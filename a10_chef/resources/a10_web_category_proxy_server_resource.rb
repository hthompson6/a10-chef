resource_name :a10_web_category_proxy_server

property :a10_name, String, name_property: true
property :username, String
property :domain, String
property :uuid, String
property :https_port, Integer
property :encrypted, String
property :proxy_host, String
property :auth_type, ['ntlm','basic']
property :http_port, Integer
property :password, [true, false]
property :secret_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/web-category/"
    get_url = "/axapi/v3/web-category/proxy-server"
    username = new_resource.username
    domain = new_resource.domain
    uuid = new_resource.uuid
    https_port = new_resource.https_port
    encrypted = new_resource.encrypted
    proxy_host = new_resource.proxy_host
    auth_type = new_resource.auth_type
    http_port = new_resource.http_port
    password = new_resource.password
    secret_string = new_resource.secret_string

    params = { "proxy-server": {"username": username,
        "domain": domain,
        "uuid": uuid,
        "https-port": https_port,
        "encrypted": encrypted,
        "proxy-host": proxy_host,
        "auth-type": auth_type,
        "http-port": http_port,
        "password": password,
        "secret-string": secret_string,} }

    params[:"proxy-server"].each do |k, v|
        if not v 
            params[:"proxy-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating proxy-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category/proxy-server"
    username = new_resource.username
    domain = new_resource.domain
    uuid = new_resource.uuid
    https_port = new_resource.https_port
    encrypted = new_resource.encrypted
    proxy_host = new_resource.proxy_host
    auth_type = new_resource.auth_type
    http_port = new_resource.http_port
    password = new_resource.password
    secret_string = new_resource.secret_string

    params = { "proxy-server": {"username": username,
        "domain": domain,
        "uuid": uuid,
        "https-port": https_port,
        "encrypted": encrypted,
        "proxy-host": proxy_host,
        "auth-type": auth_type,
        "http-port": http_port,
        "password": password,
        "secret-string": secret_string,} }

    params[:"proxy-server"].each do |k, v|
        if not v
            params[:"proxy-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["proxy-server"].each do |k, v|
        if v != params[:"proxy-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating proxy-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category/proxy-server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting proxy-server') do
            client.delete(url)
        end
    end
end