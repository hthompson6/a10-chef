resource_name :a10_snmp_server_SNMPv3_user

property :a10_name, String, name_property: true
property :username, String,required: true
property :auth_val, ['md5','sha']
property :group, String
property :uuid, String
property :encpasswd, String
property :passwd, String
property :priv_pw_encrypted, String
property :v3, ['auth','noauth']
property :pw_encrypted, String
property :priv, ['des','aes']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/SNMPv3/user/"
    get_url = "/axapi/v3/snmp-server/SNMPv3/user/%<username>s"
    username = new_resource.username
    auth_val = new_resource.auth_val
    group = new_resource.group
    uuid = new_resource.uuid
    encpasswd = new_resource.encpasswd
    passwd = new_resource.passwd
    priv_pw_encrypted = new_resource.priv_pw_encrypted
    v3 = new_resource.v3
    pw_encrypted = new_resource.pw_encrypted
    priv = new_resource.priv

    params = { "user": {"username": username,
        "auth-val": auth_val,
        "group": group,
        "uuid": uuid,
        "encpasswd": encpasswd,
        "passwd": passwd,
        "priv-pw-encrypted": priv_pw_encrypted,
        "v3": v3,
        "pw-encrypted": pw_encrypted,
        "priv": priv,} }

    params[:"user"].each do |k, v|
        if not v 
            params[:"user"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating user') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/SNMPv3/user/%<username>s"
    username = new_resource.username
    auth_val = new_resource.auth_val
    group = new_resource.group
    uuid = new_resource.uuid
    encpasswd = new_resource.encpasswd
    passwd = new_resource.passwd
    priv_pw_encrypted = new_resource.priv_pw_encrypted
    v3 = new_resource.v3
    pw_encrypted = new_resource.pw_encrypted
    priv = new_resource.priv

    params = { "user": {"username": username,
        "auth-val": auth_val,
        "group": group,
        "uuid": uuid,
        "encpasswd": encpasswd,
        "passwd": passwd,
        "priv-pw-encrypted": priv_pw_encrypted,
        "v3": v3,
        "pw-encrypted": pw_encrypted,
        "priv": priv,} }

    params[:"user"].each do |k, v|
        if not v
            params[:"user"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["user"].each do |k, v|
        if v != params[:"user"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating user') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/SNMPv3/user/%<username>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting user') do
            client.delete(url)
        end
    end
end