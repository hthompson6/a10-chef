resource_name :a10_aam_authentication_account_kerberos_spn

property :a10_name, String, name_property: true
property :account, String
property :realm, String
property :encrypted, String
property :user_tag, String
property :secret_string, String
property :password, [true, false]
property :service_principal_name, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/account/kerberos-spn/"
    get_url = "/axapi/v3/aam/authentication/account/kerberos-spn/%<name>s"
    account = new_resource.account
    realm = new_resource.realm
    a10_name = new_resource.a10_name
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    secret_string = new_resource.secret_string
    password = new_resource.password
    service_principal_name = new_resource.service_principal_name
    uuid = new_resource.uuid

    params = { "kerberos-spn": {"account": account,
        "realm": realm,
        "name": a10_name,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "secret-string": secret_string,
        "password": password,
        "service-principal-name": service_principal_name,
        "uuid": uuid,} }

    params[:"kerberos-spn"].each do |k, v|
        if not v 
            params[:"kerberos-spn"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating kerberos-spn') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/account/kerberos-spn/%<name>s"
    account = new_resource.account
    realm = new_resource.realm
    a10_name = new_resource.a10_name
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    secret_string = new_resource.secret_string
    password = new_resource.password
    service_principal_name = new_resource.service_principal_name
    uuid = new_resource.uuid

    params = { "kerberos-spn": {"account": account,
        "realm": realm,
        "name": a10_name,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "secret-string": secret_string,
        "password": password,
        "service-principal-name": service_principal_name,
        "uuid": uuid,} }

    params[:"kerberos-spn"].each do |k, v|
        if not v
            params[:"kerberos-spn"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["kerberos-spn"].each do |k, v|
        if v != params[:"kerberos-spn"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating kerberos-spn') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/account/kerberos-spn/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting kerberos-spn') do
            client.delete(url)
        end
    end
end