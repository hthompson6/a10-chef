resource_name :a10_health_monitor_method_ftp

property :a10_name, String, name_property: true
property :ftp, [true, false]
property :uuid, String
property :ftp_password_string, String
property :ftp_password, [true, false]
property :ftp_port, Integer
property :ftp_encrypted, String
property :ftp_username, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/ftp"
    ftp = new_resource.ftp
    uuid = new_resource.uuid
    ftp_password_string = new_resource.ftp_password_string
    ftp_password = new_resource.ftp_password
    ftp_port = new_resource.ftp_port
    ftp_encrypted = new_resource.ftp_encrypted
    ftp_username = new_resource.ftp_username

    params = { "ftp": {"ftp": ftp,
        "uuid": uuid,
        "ftp-password-string": ftp_password_string,
        "ftp-password": ftp_password,
        "ftp-port": ftp_port,
        "ftp-encrypted": ftp_encrypted,
        "ftp-username": ftp_username,} }

    params[:"ftp"].each do |k, v|
        if not v 
            params[:"ftp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ftp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ftp"
    ftp = new_resource.ftp
    uuid = new_resource.uuid
    ftp_password_string = new_resource.ftp_password_string
    ftp_password = new_resource.ftp_password
    ftp_port = new_resource.ftp_port
    ftp_encrypted = new_resource.ftp_encrypted
    ftp_username = new_resource.ftp_username

    params = { "ftp": {"ftp": ftp,
        "uuid": uuid,
        "ftp-password-string": ftp_password_string,
        "ftp-password": ftp_password,
        "ftp-port": ftp_port,
        "ftp-encrypted": ftp_encrypted,
        "ftp-username": ftp_username,} }

    params[:"ftp"].each do |k, v|
        if not v
            params[:"ftp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ftp"].each do |k, v|
        if v != params[:"ftp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ftp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ftp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ftp') do
            client.delete(url)
        end
    end
end