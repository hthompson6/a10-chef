resource_name :a10_health_monitor_method_tacplus

property :a10_name, String, name_property: true
property :tacplus_encrypted, String
property :secret_encrypted, String
property :uuid, String
property :tacplus_password_string, String
property :tacplus_secret, [true, false]
property :tacplus_username, String
property :tacplus, [true, false]
property :tacplus_secret_string, String
property :tacplus_type, ['inbound-ascii-login']
property :tacplus_password, [true, false]
property :tacplus_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/tacplus"
    tacplus_encrypted = new_resource.tacplus_encrypted
    secret_encrypted = new_resource.secret_encrypted
    uuid = new_resource.uuid
    tacplus_password_string = new_resource.tacplus_password_string
    tacplus_secret = new_resource.tacplus_secret
    tacplus_username = new_resource.tacplus_username
    tacplus = new_resource.tacplus
    tacplus_secret_string = new_resource.tacplus_secret_string
    tacplus_type = new_resource.tacplus_type
    tacplus_password = new_resource.tacplus_password
    tacplus_port = new_resource.tacplus_port

    params = { "tacplus": {"tacplus-encrypted": tacplus_encrypted,
        "secret-encrypted": secret_encrypted,
        "uuid": uuid,
        "tacplus-password-string": tacplus_password_string,
        "tacplus-secret": tacplus_secret,
        "tacplus-username": tacplus_username,
        "tacplus": tacplus,
        "tacplus-secret-string": tacplus_secret_string,
        "tacplus-type": tacplus_type,
        "tacplus-password": tacplus_password,
        "tacplus-port": tacplus_port,} }

    params[:"tacplus"].each do |k, v|
        if not v 
            params[:"tacplus"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tacplus') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/tacplus"
    tacplus_encrypted = new_resource.tacplus_encrypted
    secret_encrypted = new_resource.secret_encrypted
    uuid = new_resource.uuid
    tacplus_password_string = new_resource.tacplus_password_string
    tacplus_secret = new_resource.tacplus_secret
    tacplus_username = new_resource.tacplus_username
    tacplus = new_resource.tacplus
    tacplus_secret_string = new_resource.tacplus_secret_string
    tacplus_type = new_resource.tacplus_type
    tacplus_password = new_resource.tacplus_password
    tacplus_port = new_resource.tacplus_port

    params = { "tacplus": {"tacplus-encrypted": tacplus_encrypted,
        "secret-encrypted": secret_encrypted,
        "uuid": uuid,
        "tacplus-password-string": tacplus_password_string,
        "tacplus-secret": tacplus_secret,
        "tacplus-username": tacplus_username,
        "tacplus": tacplus,
        "tacplus-secret-string": tacplus_secret_string,
        "tacplus-type": tacplus_type,
        "tacplus-password": tacplus_password,
        "tacplus-port": tacplus_port,} }

    params[:"tacplus"].each do |k, v|
        if not v
            params[:"tacplus"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tacplus"].each do |k, v|
        if v != params[:"tacplus"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tacplus') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/tacplus"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tacplus') do
            client.delete(url)
        end
    end
end