resource_name :a10_authentication

property :a10_name, String, name_property: true
property :console, Hash
property :uuid, String
property :mode_cfg, Hash
property :type_cfg, Hash
property :multiple_auth_reject, [true, false]
property :login_cfg, Hash
property :enable_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/authentication"
    console = new_resource.console
    uuid = new_resource.uuid
    mode_cfg = new_resource.mode_cfg
    type_cfg = new_resource.type_cfg
    multiple_auth_reject = new_resource.multiple_auth_reject
    login_cfg = new_resource.login_cfg
    enable_cfg = new_resource.enable_cfg

    params = { "authentication": {"console": console,
        "uuid": uuid,
        "mode-cfg": mode_cfg,
        "type-cfg": type_cfg,
        "multiple-auth-reject": multiple_auth_reject,
        "login-cfg": login_cfg,
        "enable-cfg": enable_cfg,} }

    params[:"authentication"].each do |k, v|
        if not v 
            params[:"authentication"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating authentication') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/authentication"
    console = new_resource.console
    uuid = new_resource.uuid
    mode_cfg = new_resource.mode_cfg
    type_cfg = new_resource.type_cfg
    multiple_auth_reject = new_resource.multiple_auth_reject
    login_cfg = new_resource.login_cfg
    enable_cfg = new_resource.enable_cfg

    params = { "authentication": {"console": console,
        "uuid": uuid,
        "mode-cfg": mode_cfg,
        "type-cfg": type_cfg,
        "multiple-auth-reject": multiple_auth_reject,
        "login-cfg": login_cfg,
        "enable-cfg": enable_cfg,} }

    params[:"authentication"].each do |k, v|
        if not v
            params[:"authentication"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["authentication"].each do |k, v|
        if v != params[:"authentication"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating authentication') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/authentication"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting authentication') do
            client.delete(url)
        end
    end
end