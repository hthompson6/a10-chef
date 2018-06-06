resource_name :a10_aam_authentication_server_windows_instance

property :a10_name, String, name_property: true
property :health_check_string, String
property :realm, String
property :kerberos_password_change_port, Integer
property :sampling_enable, Array
property :host, Hash
property :timeout, Integer
property :auth_protocol, Hash
property :health_check_disable, [true, false]
property :support_apacheds_kdc, [true, false]
property :health_check, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/windows/instance/"
    get_url = "/axapi/v3/aam/authentication/server/windows/instance/%<name>s"
    health_check_string = new_resource.health_check_string
    realm = new_resource.realm
    kerberos_password_change_port = new_resource.kerberos_password_change_port
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    host = new_resource.host
    timeout = new_resource.timeout
    auth_protocol = new_resource.auth_protocol
    health_check_disable = new_resource.health_check_disable
    support_apacheds_kdc = new_resource.support_apacheds_kdc
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "instance": {"health-check-string": health_check_string,
        "realm": realm,
        "kerberos-password-change-port": kerberos_password_change_port,
        "sampling-enable": sampling_enable,
        "name": a10_name,
        "host": host,
        "timeout": timeout,
        "auth-protocol": auth_protocol,
        "health-check-disable": health_check_disable,
        "support-apacheds-kdc": support_apacheds_kdc,
        "health-check": health_check,
        "uuid": uuid,} }

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
    url = "/axapi/v3/aam/authentication/server/windows/instance/%<name>s"
    health_check_string = new_resource.health_check_string
    realm = new_resource.realm
    kerberos_password_change_port = new_resource.kerberos_password_change_port
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    host = new_resource.host
    timeout = new_resource.timeout
    auth_protocol = new_resource.auth_protocol
    health_check_disable = new_resource.health_check_disable
    support_apacheds_kdc = new_resource.support_apacheds_kdc
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "instance": {"health-check-string": health_check_string,
        "realm": realm,
        "kerberos-password-change-port": kerberos_password_change_port,
        "sampling-enable": sampling_enable,
        "name": a10_name,
        "host": host,
        "timeout": timeout,
        "auth-protocol": auth_protocol,
        "health-check-disable": health_check_disable,
        "support-apacheds-kdc": support_apacheds_kdc,
        "health-check": health_check,
        "uuid": uuid,} }

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
    url = "/axapi/v3/aam/authentication/server/windows/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end