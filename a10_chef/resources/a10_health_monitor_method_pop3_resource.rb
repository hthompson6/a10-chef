resource_name :a10_health_monitor_method_pop3

property :a10_name, String, name_property: true
property :pop3_password_string, String
property :uuid, String
property :pop3_password, [true, false]
property :pop3_username, String
property :pop3_encrypted, String
property :pop3, [true, false]
property :pop3_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/pop3"
    pop3_password_string = new_resource.pop3_password_string
    uuid = new_resource.uuid
    pop3_password = new_resource.pop3_password
    pop3_username = new_resource.pop3_username
    pop3_encrypted = new_resource.pop3_encrypted
    pop3 = new_resource.pop3
    pop3_port = new_resource.pop3_port

    params = { "pop3": {"pop3-password-string": pop3_password_string,
        "uuid": uuid,
        "pop3-password": pop3_password,
        "pop3-username": pop3_username,
        "pop3-encrypted": pop3_encrypted,
        "pop3": pop3,
        "pop3-port": pop3_port,} }

    params[:"pop3"].each do |k, v|
        if not v 
            params[:"pop3"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pop3') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/pop3"
    pop3_password_string = new_resource.pop3_password_string
    uuid = new_resource.uuid
    pop3_password = new_resource.pop3_password
    pop3_username = new_resource.pop3_username
    pop3_encrypted = new_resource.pop3_encrypted
    pop3 = new_resource.pop3
    pop3_port = new_resource.pop3_port

    params = { "pop3": {"pop3-password-string": pop3_password_string,
        "uuid": uuid,
        "pop3-password": pop3_password,
        "pop3-username": pop3_username,
        "pop3-encrypted": pop3_encrypted,
        "pop3": pop3,
        "pop3-port": pop3_port,} }

    params[:"pop3"].each do |k, v|
        if not v
            params[:"pop3"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pop3"].each do |k, v|
        if v != params[:"pop3"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pop3') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/pop3"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pop3') do
            client.delete(url)
        end
    end
end