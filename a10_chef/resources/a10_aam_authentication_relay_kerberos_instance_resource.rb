resource_name :a10_aam_authentication_relay_kerberos_instance

property :a10_name, String, name_property: true
property :kerberos_account, String
property :uuid, String
property :encrypted, String
property :kerberos_realm, String
property :kerberos_kdc_service_group, String
property :sampling_enable, Array
property :timeout, Integer
property :password, [true, false]
property :kerberos_kdc, String
property :port, Integer
property :secret_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/kerberos/instance/"
    get_url = "/axapi/v3/aam/authentication/relay/kerberos/instance/%<name>s"
    kerberos_account = new_resource.kerberos_account
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    kerberos_realm = new_resource.kerberos_realm
    kerberos_kdc_service_group = new_resource.kerberos_kdc_service_group
    sampling_enable = new_resource.sampling_enable
    timeout = new_resource.timeout
    password = new_resource.password
    kerberos_kdc = new_resource.kerberos_kdc
    port = new_resource.port
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name

    params = { "instance": {"kerberos-account": kerberos_account,
        "uuid": uuid,
        "encrypted": encrypted,
        "kerberos-realm": kerberos_realm,
        "kerberos-kdc-service-group": kerberos_kdc_service_group,
        "sampling-enable": sampling_enable,
        "timeout": timeout,
        "password": password,
        "kerberos-kdc": kerberos_kdc,
        "port": port,
        "secret-string": secret_string,
        "name": a10_name,} }

    params[:"instance"].each do |k, v|
        if not v 
            params[:"instance"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating instance') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/kerberos/instance/%<name>s"
    kerberos_account = new_resource.kerberos_account
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    kerberos_realm = new_resource.kerberos_realm
    kerberos_kdc_service_group = new_resource.kerberos_kdc_service_group
    sampling_enable = new_resource.sampling_enable
    timeout = new_resource.timeout
    password = new_resource.password
    kerberos_kdc = new_resource.kerberos_kdc
    port = new_resource.port
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name

    params = { "instance": {"kerberos-account": kerberos_account,
        "uuid": uuid,
        "encrypted": encrypted,
        "kerberos-realm": kerberos_realm,
        "kerberos-kdc-service-group": kerberos_kdc_service_group,
        "sampling-enable": sampling_enable,
        "timeout": timeout,
        "password": password,
        "kerberos-kdc": kerberos_kdc,
        "port": port,
        "secret-string": secret_string,
        "name": a10_name,} }

    params[:"instance"].each do |k, v|
        if not v
            params[:"instance"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["instance"].each do |k, v|
        if v != params[:"instance"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating instance') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/kerberos/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end