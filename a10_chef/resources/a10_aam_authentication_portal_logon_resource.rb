resource_name :a10_aam_authentication_portal_logon

property :a10_name, String, name_property: true
property :action_url, String
property :submit_text, String
property :passcode_cfg, Hash
property :username_cfg, Hash
property :username_var, String
property :password_var, String
property :background, Hash
property :passcode_var, String
property :fail_msg_cfg, Hash
property :password_cfg, Hash
property :enable_passcode, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/portal/%<name>s/"
    get_url = "/axapi/v3/aam/authentication/portal/%<name>s/logon"
    action_url = new_resource.action_url
    submit_text = new_resource.submit_text
    passcode_cfg = new_resource.passcode_cfg
    username_cfg = new_resource.username_cfg
    username_var = new_resource.username_var
    password_var = new_resource.password_var
    background = new_resource.background
    passcode_var = new_resource.passcode_var
    fail_msg_cfg = new_resource.fail_msg_cfg
    password_cfg = new_resource.password_cfg
    enable_passcode = new_resource.enable_passcode
    uuid = new_resource.uuid

    params = { "logon": {"action-url": action_url,
        "submit-text": submit_text,
        "passcode-cfg": passcode_cfg,
        "username-cfg": username_cfg,
        "username-var": username_var,
        "password-var": password_var,
        "background": background,
        "passcode-var": passcode_var,
        "fail-msg-cfg": fail_msg_cfg,
        "password-cfg": password_cfg,
        "enable-passcode": enable_passcode,
        "uuid": uuid,} }

    params[:"logon"].each do |k, v|
        if not v 
            params[:"logon"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating logon') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/logon"
    action_url = new_resource.action_url
    submit_text = new_resource.submit_text
    passcode_cfg = new_resource.passcode_cfg
    username_cfg = new_resource.username_cfg
    username_var = new_resource.username_var
    password_var = new_resource.password_var
    background = new_resource.background
    passcode_var = new_resource.passcode_var
    fail_msg_cfg = new_resource.fail_msg_cfg
    password_cfg = new_resource.password_cfg
    enable_passcode = new_resource.enable_passcode
    uuid = new_resource.uuid

    params = { "logon": {"action-url": action_url,
        "submit-text": submit_text,
        "passcode-cfg": passcode_cfg,
        "username-cfg": username_cfg,
        "username-var": username_var,
        "password-var": password_var,
        "background": background,
        "passcode-var": passcode_var,
        "fail-msg-cfg": fail_msg_cfg,
        "password-cfg": password_cfg,
        "enable-passcode": enable_passcode,
        "uuid": uuid,} }

    params[:"logon"].each do |k, v|
        if not v
            params[:"logon"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["logon"].each do |k, v|
        if v != params[:"logon"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating logon') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/logon"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logon') do
            client.delete(url)
        end
    end
end