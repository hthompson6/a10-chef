resource_name :a10_admin

property :a10_name, String, name_property: true
property :ssh_pubkey, Hash
property :uuid, String
property :privilege_global, ['read','write']
property :trusted_host, [true, false]
property :user, String,required: true
property :privilege_list, Array
property :user_tag, String
property :access, Hash
property :access_list, [true, false]
property :unlock, [true, false]
property :password_key, [true, false]
property :trusted_host_acl_id, Integer
property :password, Hash
property :a10_action, ['enable','disable']
property :trusted_host_cidr, String
property :passwd_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/admin/"
    get_url = "/axapi/v3/admin/%<user>s"
    ssh_pubkey = new_resource.ssh_pubkey
    uuid = new_resource.uuid
    privilege_global = new_resource.privilege_global
    trusted_host = new_resource.trusted_host
    user = new_resource.user
    privilege_list = new_resource.privilege_list
    user_tag = new_resource.user_tag
    access = new_resource.access
    access_list = new_resource.access_list
    unlock = new_resource.unlock
    password_key = new_resource.password_key
    trusted_host_acl_id = new_resource.trusted_host_acl_id
    password = new_resource.password
    a10_name = new_resource.a10_name
    trusted_host_cidr = new_resource.trusted_host_cidr
    passwd_string = new_resource.passwd_string

    params = { "admin": {"ssh-pubkey": ssh_pubkey,
        "uuid": uuid,
        "privilege-global": privilege_global,
        "trusted-host": trusted_host,
        "user": user,
        "privilege-list": privilege_list,
        "user-tag": user_tag,
        "access": access,
        "access-list": access_list,
        "unlock": unlock,
        "password-key": password_key,
        "trusted-host-acl-id": trusted_host_acl_id,
        "password": password,
        "action": a10_action,
        "trusted-host-cidr": trusted_host_cidr,
        "passwd-string": passwd_string,} }

    params[:"admin"].each do |k, v|
        if not v 
            params[:"admin"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating admin') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s"
    ssh_pubkey = new_resource.ssh_pubkey
    uuid = new_resource.uuid
    privilege_global = new_resource.privilege_global
    trusted_host = new_resource.trusted_host
    user = new_resource.user
    privilege_list = new_resource.privilege_list
    user_tag = new_resource.user_tag
    access = new_resource.access
    access_list = new_resource.access_list
    unlock = new_resource.unlock
    password_key = new_resource.password_key
    trusted_host_acl_id = new_resource.trusted_host_acl_id
    password = new_resource.password
    a10_name = new_resource.a10_name
    trusted_host_cidr = new_resource.trusted_host_cidr
    passwd_string = new_resource.passwd_string

    params = { "admin": {"ssh-pubkey": ssh_pubkey,
        "uuid": uuid,
        "privilege-global": privilege_global,
        "trusted-host": trusted_host,
        "user": user,
        "privilege-list": privilege_list,
        "user-tag": user_tag,
        "access": access,
        "access-list": access_list,
        "unlock": unlock,
        "password-key": password_key,
        "trusted-host-acl-id": trusted_host_acl_id,
        "password": password,
        "action": a10_action,
        "trusted-host-cidr": trusted_host_cidr,
        "passwd-string": passwd_string,} }

    params[:"admin"].each do |k, v|
        if not v
            params[:"admin"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["admin"].each do |k, v|
        if v != params[:"admin"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating admin') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting admin') do
            client.delete(url)
        end
    end
end