resource_name :a10_glm_proxy_server

property :a10_name, String, name_property: true
property :username, String
property :uuid, String
property :encrypted, String
property :host, String
property :password, [true, false]
property :port, Integer
property :secret_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/glm/"
    get_url = "/axapi/v3/glm/proxy-server"
    username = new_resource.username
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    host = new_resource.host
    password = new_resource.password
    port = new_resource.port
    secret_string = new_resource.secret_string

    params = { "proxy-server": {"username": username,
        "uuid": uuid,
        "encrypted": encrypted,
        "host": host,
        "password": password,
        "port": port,
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
    url = "/axapi/v3/glm/proxy-server"
    username = new_resource.username
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    host = new_resource.host
    password = new_resource.password
    port = new_resource.port
    secret_string = new_resource.secret_string

    params = { "proxy-server": {"username": username,
        "uuid": uuid,
        "encrypted": encrypted,
        "host": host,
        "password": password,
        "port": port,
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
    url = "/axapi/v3/glm/proxy-server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting proxy-server') do
            client.delete(url)
        end
    end
end