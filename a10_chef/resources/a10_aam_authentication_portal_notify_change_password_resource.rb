resource_name :a10_aam_authentication_portal_notify_change_password

property :a10_name, String, name_property: true
property :old_pwd_cfg, Hash
property :username_var, String
property :new_pwd_cfg, Hash
property :uuid, String
property :cfm_pwd_cfg, Hash
property :confirm_password_var, String
property :new_password_var, String
property :change_url, String
property :continue_url, String
property :background, Hash
property :old_password_var, String
property :change_text, String
property :continue_text, String
property :username_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/portal/%<name>s/"
    get_url = "/axapi/v3/aam/authentication/portal/%<name>s/notify-change-password"
    old_pwd_cfg = new_resource.old_pwd_cfg
    username_var = new_resource.username_var
    new_pwd_cfg = new_resource.new_pwd_cfg
    uuid = new_resource.uuid
    cfm_pwd_cfg = new_resource.cfm_pwd_cfg
    confirm_password_var = new_resource.confirm_password_var
    new_password_var = new_resource.new_password_var
    change_url = new_resource.change_url
    continue_url = new_resource.continue_url
    background = new_resource.background
    old_password_var = new_resource.old_password_var
    change_text = new_resource.change_text
    continue_text = new_resource.continue_text
    username_cfg = new_resource.username_cfg

    params = { "notify-change-password": {"old-pwd-cfg": old_pwd_cfg,
        "username-var": username_var,
        "new-pwd-cfg": new_pwd_cfg,
        "uuid": uuid,
        "cfm-pwd-cfg": cfm_pwd_cfg,
        "confirm-password-var": confirm_password_var,
        "new-password-var": new_password_var,
        "change-url": change_url,
        "continue-url": continue_url,
        "background": background,
        "old-password-var": old_password_var,
        "change-text": change_text,
        "continue-text": continue_text,
        "username-cfg": username_cfg,} }

    params[:"notify-change-password"].each do |k, v|
        if not v 
            params[:"notify-change-password"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating notify-change-password') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/notify-change-password"
    old_pwd_cfg = new_resource.old_pwd_cfg
    username_var = new_resource.username_var
    new_pwd_cfg = new_resource.new_pwd_cfg
    uuid = new_resource.uuid
    cfm_pwd_cfg = new_resource.cfm_pwd_cfg
    confirm_password_var = new_resource.confirm_password_var
    new_password_var = new_resource.new_password_var
    change_url = new_resource.change_url
    continue_url = new_resource.continue_url
    background = new_resource.background
    old_password_var = new_resource.old_password_var
    change_text = new_resource.change_text
    continue_text = new_resource.continue_text
    username_cfg = new_resource.username_cfg

    params = { "notify-change-password": {"old-pwd-cfg": old_pwd_cfg,
        "username-var": username_var,
        "new-pwd-cfg": new_pwd_cfg,
        "uuid": uuid,
        "cfm-pwd-cfg": cfm_pwd_cfg,
        "confirm-password-var": confirm_password_var,
        "new-password-var": new_password_var,
        "change-url": change_url,
        "continue-url": continue_url,
        "background": background,
        "old-password-var": old_password_var,
        "change-text": change_text,
        "continue-text": continue_text,
        "username-cfg": username_cfg,} }

    params[:"notify-change-password"].each do |k, v|
        if not v
            params[:"notify-change-password"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["notify-change-password"].each do |k, v|
        if v != params[:"notify-change-password"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating notify-change-password') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/notify-change-password"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting notify-change-password') do
            client.delete(url)
        end
    end
end