resource_name :a10_aam_authentication_server_radius_instance

property :a10_name, String, name_property: true
property :auth_type, ['pap','mschapv2','mschapv2-pap']
property :health_check_string, String
property :a10_retry, Integer
property :port_hm, String
property :port_hm_disable, [true, false]
property :encrypted, String
property :interval, Integer
property :accounting_port, Integer
property :port, Integer
property :health_check, [true, false]
property :acct_port_hm_disable, [true, false]
property :secret, [true, false]
property :sampling_enable, Array
property :host, Hash
property :health_check_disable, [true, false]
property :secret_string, String
property :acct_port_hm, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/radius/instance/"
    get_url = "/axapi/v3/aam/authentication/server/radius/instance/%<name>s"
    auth_type = new_resource.auth_type
    health_check_string = new_resource.health_check_string
    a10_name = new_resource.a10_name
    port_hm = new_resource.port_hm
    a10_name = new_resource.a10_name
    port_hm_disable = new_resource.port_hm_disable
    encrypted = new_resource.encrypted
    interval = new_resource.interval
    accounting_port = new_resource.accounting_port
    port = new_resource.port
    health_check = new_resource.health_check
    acct_port_hm_disable = new_resource.acct_port_hm_disable
    secret = new_resource.secret
    sampling_enable = new_resource.sampling_enable
    host = new_resource.host
    health_check_disable = new_resource.health_check_disable
    secret_string = new_resource.secret_string
    acct_port_hm = new_resource.acct_port_hm
    uuid = new_resource.uuid

    params = { "instance": {"auth-type": auth_type,
        "health-check-string": health_check_string,
        "retry": a10_retry,
        "port-hm": port_hm,
        "name": a10_name,
        "port-hm-disable": port_hm_disable,
        "encrypted": encrypted,
        "interval": interval,
        "accounting-port": accounting_port,
        "port": port,
        "health-check": health_check,
        "acct-port-hm-disable": acct_port_hm_disable,
        "secret": secret,
        "sampling-enable": sampling_enable,
        "host": host,
        "health-check-disable": health_check_disable,
        "secret-string": secret_string,
        "acct-port-hm": acct_port_hm,
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
    url = "/axapi/v3/aam/authentication/server/radius/instance/%<name>s"
    auth_type = new_resource.auth_type
    health_check_string = new_resource.health_check_string
    a10_name = new_resource.a10_name
    port_hm = new_resource.port_hm
    a10_name = new_resource.a10_name
    port_hm_disable = new_resource.port_hm_disable
    encrypted = new_resource.encrypted
    interval = new_resource.interval
    accounting_port = new_resource.accounting_port
    port = new_resource.port
    health_check = new_resource.health_check
    acct_port_hm_disable = new_resource.acct_port_hm_disable
    secret = new_resource.secret
    sampling_enable = new_resource.sampling_enable
    host = new_resource.host
    health_check_disable = new_resource.health_check_disable
    secret_string = new_resource.secret_string
    acct_port_hm = new_resource.acct_port_hm
    uuid = new_resource.uuid

    params = { "instance": {"auth-type": auth_type,
        "health-check-string": health_check_string,
        "retry": a10_retry,
        "port-hm": port_hm,
        "name": a10_name,
        "port-hm-disable": port_hm_disable,
        "encrypted": encrypted,
        "interval": interval,
        "accounting-port": accounting_port,
        "port": port,
        "health-check": health_check,
        "acct-port-hm-disable": acct_port_hm_disable,
        "secret": secret,
        "sampling-enable": sampling_enable,
        "host": host,
        "health-check-disable": health_check_disable,
        "secret-string": secret_string,
        "acct-port-hm": acct_port_hm,
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
    url = "/axapi/v3/aam/authentication/server/radius/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end