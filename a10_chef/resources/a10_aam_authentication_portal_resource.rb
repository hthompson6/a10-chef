resource_name :a10_aam_authentication_portal

property :a10_name, String, name_property: true
property :logon_fail, Hash
property :logo_cfg, Hash
property :user_tag, String
property :notify_change_password, Hash
property :logon, Hash
property :change_password, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/portal/"
    get_url = "/axapi/v3/aam/authentication/portal/%<name>s"
    a10_name = new_resource.a10_name
    logon_fail = new_resource.logon_fail
    logo_cfg = new_resource.logo_cfg
    user_tag = new_resource.user_tag
    notify_change_password = new_resource.notify_change_password
    logon = new_resource.logon
    change_password = new_resource.change_password
    uuid = new_resource.uuid

    params = { "portal": {"name": a10_name,
        "logon-fail": logon_fail,
        "logo-cfg": logo_cfg,
        "user-tag": user_tag,
        "notify-change-password": notify_change_password,
        "logon": logon,
        "change-password": change_password,
        "uuid": uuid,} }

    params[:"portal"].each do |k, v|
        if not v 
            params[:"portal"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating portal') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s"
    a10_name = new_resource.a10_name
    logon_fail = new_resource.logon_fail
    logo_cfg = new_resource.logo_cfg
    user_tag = new_resource.user_tag
    notify_change_password = new_resource.notify_change_password
    logon = new_resource.logon
    change_password = new_resource.change_password
    uuid = new_resource.uuid

    params = { "portal": {"name": a10_name,
        "logon-fail": logon_fail,
        "logo-cfg": logo_cfg,
        "user-tag": user_tag,
        "notify-change-password": notify_change_password,
        "logon": logon,
        "change-password": change_password,
        "uuid": uuid,} }

    params[:"portal"].each do |k, v|
        if not v
            params[:"portal"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["portal"].each do |k, v|
        if v != params[:"portal"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating portal') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting portal') do
            client.delete(url)
        end
    end
end