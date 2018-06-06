resource_name :a10_health_monitor_method_imap

property :a10_name, String, name_property: true
property :imap_cram_md5, [true, false]
property :imap_port, Integer
property :imap_login, [true, false]
property :imap_password, [true, false]
property :imap_password_string, String
property :imap_username, String
property :imap_encrypted, String
property :pwd_auth, [true, false]
property :imap_plain, [true, false]
property :imap, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/imap"
    imap_cram_md5 = new_resource.imap_cram_md5
    imap_port = new_resource.imap_port
    imap_login = new_resource.imap_login
    imap_password = new_resource.imap_password
    imap_password_string = new_resource.imap_password_string
    imap_username = new_resource.imap_username
    imap_encrypted = new_resource.imap_encrypted
    pwd_auth = new_resource.pwd_auth
    imap_plain = new_resource.imap_plain
    imap = new_resource.imap
    uuid = new_resource.uuid

    params = { "imap": {"imap-cram-md5": imap_cram_md5,
        "imap-port": imap_port,
        "imap-login": imap_login,
        "imap-password": imap_password,
        "imap-password-string": imap_password_string,
        "imap-username": imap_username,
        "imap-encrypted": imap_encrypted,
        "pwd-auth": pwd_auth,
        "imap-plain": imap_plain,
        "imap": imap,
        "uuid": uuid,} }

    params[:"imap"].each do |k, v|
        if not v 
            params[:"imap"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating imap') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/imap"
    imap_cram_md5 = new_resource.imap_cram_md5
    imap_port = new_resource.imap_port
    imap_login = new_resource.imap_login
    imap_password = new_resource.imap_password
    imap_password_string = new_resource.imap_password_string
    imap_username = new_resource.imap_username
    imap_encrypted = new_resource.imap_encrypted
    pwd_auth = new_resource.pwd_auth
    imap_plain = new_resource.imap_plain
    imap = new_resource.imap
    uuid = new_resource.uuid

    params = { "imap": {"imap-cram-md5": imap_cram_md5,
        "imap-port": imap_port,
        "imap-login": imap_login,
        "imap-password": imap_password,
        "imap-password-string": imap_password_string,
        "imap-username": imap_username,
        "imap-encrypted": imap_encrypted,
        "pwd-auth": pwd_auth,
        "imap-plain": imap_plain,
        "imap": imap,
        "uuid": uuid,} }

    params[:"imap"].each do |k, v|
        if not v
            params[:"imap"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["imap"].each do |k, v|
        if v != params[:"imap"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating imap') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/imap"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting imap') do
            client.delete(url)
        end
    end
end