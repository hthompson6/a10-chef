resource_name :a10_aam_authentication_logon_http_authenticate_instance

property :a10_name, String, name_property: true
property :a10_retry, Integer
property :uuid, String
property :sampling_enable, Array
property :account_lock, [true, false]
property :duration, Integer
property :auth_method, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/logon/http-authenticate/instance/"
    get_url = "/axapi/v3/aam/authentication/logon/http-authenticate/instance/%<name>s"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    account_lock = new_resource.account_lock
    duration = new_resource.duration
    auth_method = new_resource.auth_method

    params = { "instance": {"retry": a10_retry,
        "uuid": uuid,
        "name": a10_name,
        "sampling-enable": sampling_enable,
        "account-lock": account_lock,
        "duration": duration,
        "auth-method": auth_method,} }

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
    url = "/axapi/v3/aam/authentication/logon/http-authenticate/instance/%<name>s"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    account_lock = new_resource.account_lock
    duration = new_resource.duration
    auth_method = new_resource.auth_method

    params = { "instance": {"retry": a10_retry,
        "uuid": uuid,
        "name": a10_name,
        "sampling-enable": sampling_enable,
        "account-lock": account_lock,
        "duration": duration,
        "auth-method": auth_method,} }

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
    url = "/axapi/v3/aam/authentication/logon/http-authenticate/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end