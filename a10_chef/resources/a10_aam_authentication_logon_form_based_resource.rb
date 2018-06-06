resource_name :a10_aam_authentication_logon_form_based

property :a10_name, String, name_property: true
property :logon_page_cfg, Hash
property :a10_retry, Integer
property :next_token_variable, String
property :challenge_variable, String
property :notify_cp_page_cfg, Hash
property :new_pin_variable, String
property :portal, Hash
property :user_tag, String
property :account_lock, [true, false]
property :duration, Integer
property :cp_page_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/logon/form-based/"
    get_url = "/axapi/v3/aam/authentication/logon/form-based/%<name>s"
    logon_page_cfg = new_resource.logon_page_cfg
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    next_token_variable = new_resource.next_token_variable
    challenge_variable = new_resource.challenge_variable
    notify_cp_page_cfg = new_resource.notify_cp_page_cfg
    new_pin_variable = new_resource.new_pin_variable
    portal = new_resource.portal
    user_tag = new_resource.user_tag
    account_lock = new_resource.account_lock
    duration = new_resource.duration
    cp_page_cfg = new_resource.cp_page_cfg
    uuid = new_resource.uuid

    params = { "form-based": {"logon-page-cfg": logon_page_cfg,
        "retry": a10_retry,
        "name": a10_name,
        "next-token-variable": next_token_variable,
        "challenge-variable": challenge_variable,
        "notify-cp-page-cfg": notify_cp_page_cfg,
        "new-pin-variable": new_pin_variable,
        "portal": portal,
        "user-tag": user_tag,
        "account-lock": account_lock,
        "duration": duration,
        "cp-page-cfg": cp_page_cfg,
        "uuid": uuid,} }

    params[:"form-based"].each do |k, v|
        if not v 
            params[:"form-based"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating form-based') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/logon/form-based/%<name>s"
    logon_page_cfg = new_resource.logon_page_cfg
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    next_token_variable = new_resource.next_token_variable
    challenge_variable = new_resource.challenge_variable
    notify_cp_page_cfg = new_resource.notify_cp_page_cfg
    new_pin_variable = new_resource.new_pin_variable
    portal = new_resource.portal
    user_tag = new_resource.user_tag
    account_lock = new_resource.account_lock
    duration = new_resource.duration
    cp_page_cfg = new_resource.cp_page_cfg
    uuid = new_resource.uuid

    params = { "form-based": {"logon-page-cfg": logon_page_cfg,
        "retry": a10_retry,
        "name": a10_name,
        "next-token-variable": next_token_variable,
        "challenge-variable": challenge_variable,
        "notify-cp-page-cfg": notify_cp_page_cfg,
        "new-pin-variable": new_pin_variable,
        "portal": portal,
        "user-tag": user_tag,
        "account-lock": account_lock,
        "duration": duration,
        "cp-page-cfg": cp_page_cfg,
        "uuid": uuid,} }

    params[:"form-based"].each do |k, v|
        if not v
            params[:"form-based"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["form-based"].each do |k, v|
        if v != params[:"form-based"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating form-based') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/logon/form-based/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting form-based') do
            client.delete(url)
        end
    end
end