resource_name :a10_aam_authentication_portal_change_password

property :a10_name, String, name_property: true
property :action_url, String
property :username_var, String
property :new_pwd_cfg, Hash
property :submit_text, String
property :uuid, String
property :confirm_password_var, String
property :title_cfg, Hash
property :username_cfg, Hash
property :new_password_var, String
property :old_pwd_cfg, Hash
property :background, Hash
property :old_password_var, String
property :cfm_pwd_cfg, Hash
property :reset_text, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/portal/%<name>s/"
    get_url = "/axapi/v3/aam/authentication/portal/%<name>s/change-password"
    action_url = new_resource.action_url
    username_var = new_resource.username_var
    new_pwd_cfg = new_resource.new_pwd_cfg
    submit_text = new_resource.submit_text
    uuid = new_resource.uuid
    confirm_password_var = new_resource.confirm_password_var
    title_cfg = new_resource.title_cfg
    username_cfg = new_resource.username_cfg
    new_password_var = new_resource.new_password_var
    old_pwd_cfg = new_resource.old_pwd_cfg
    background = new_resource.background
    old_password_var = new_resource.old_password_var
    cfm_pwd_cfg = new_resource.cfm_pwd_cfg
    reset_text = new_resource.reset_text

    params = { "change-password": {"action-url": action_url,
        "username-var": username_var,
        "new-pwd-cfg": new_pwd_cfg,
        "submit-text": submit_text,
        "uuid": uuid,
        "confirm-password-var": confirm_password_var,
        "title-cfg": title_cfg,
        "username-cfg": username_cfg,
        "new-password-var": new_password_var,
        "old-pwd-cfg": old_pwd_cfg,
        "background": background,
        "old-password-var": old_password_var,
        "cfm-pwd-cfg": cfm_pwd_cfg,
        "reset-text": reset_text,} }

    params[:"change-password"].each do |k, v|
        if not v 
            params[:"change-password"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating change-password') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/change-password"
    action_url = new_resource.action_url
    username_var = new_resource.username_var
    new_pwd_cfg = new_resource.new_pwd_cfg
    submit_text = new_resource.submit_text
    uuid = new_resource.uuid
    confirm_password_var = new_resource.confirm_password_var
    title_cfg = new_resource.title_cfg
    username_cfg = new_resource.username_cfg
    new_password_var = new_resource.new_password_var
    old_pwd_cfg = new_resource.old_pwd_cfg
    background = new_resource.background
    old_password_var = new_resource.old_password_var
    cfm_pwd_cfg = new_resource.cfm_pwd_cfg
    reset_text = new_resource.reset_text

    params = { "change-password": {"action-url": action_url,
        "username-var": username_var,
        "new-pwd-cfg": new_pwd_cfg,
        "submit-text": submit_text,
        "uuid": uuid,
        "confirm-password-var": confirm_password_var,
        "title-cfg": title_cfg,
        "username-cfg": username_cfg,
        "new-password-var": new_password_var,
        "old-pwd-cfg": old_pwd_cfg,
        "background": background,
        "old-password-var": old_password_var,
        "cfm-pwd-cfg": cfm_pwd_cfg,
        "reset-text": reset_text,} }

    params[:"change-password"].each do |k, v|
        if not v
            params[:"change-password"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["change-password"].each do |k, v|
        if v != params[:"change-password"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating change-password') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/change-password"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting change-password') do
            client.delete(url)
        end
    end
end