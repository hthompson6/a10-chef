resource_name :a10_snmp_server_SNMPv1_v2c_user

property :a10_name, String, name_property: true
property :remote, Hash
property :uuid, String
property :passwd, String
property :encrypted, String
property :user_tag, String
property :user, String,required: true
property :oid_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/"
    get_url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s"
    remote = new_resource.remote
    uuid = new_resource.uuid
    passwd = new_resource.passwd
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    user = new_resource.user
    oid_list = new_resource.oid_list

    params = { "user": {"remote": remote,
        "uuid": uuid,
        "passwd": passwd,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "user": user,
        "oid-list": oid_list,} }

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
    url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s"
    remote = new_resource.remote
    uuid = new_resource.uuid
    passwd = new_resource.passwd
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    user = new_resource.user
    oid_list = new_resource.oid_list

    params = { "user": {"remote": remote,
        "uuid": uuid,
        "passwd": passwd,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "user": user,
        "oid-list": oid_list,} }

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
    url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting user') do
            client.delete(url)
        end
    end
end