resource_name :a10_aam_authentication_template

property :a10_name, String, name_property: true
property :max_session_time, Integer
property :accounting_server, String
property :saml_idp, String
property :cookie_max_age, Integer
property :uuid, String
property :local_logging, [true, false]
property :auth_sess_mode, ['cookie-based','ip-based']
property :service_group, String
property :ntype, ['saml','standard']
property :modify_content_security_policy, [true, false]
property :relay, String
property :saml_sp, String
property :cookie_domain, Array
property :cookie_domain_group, Array
property :forward_logout_disable, [true, false]
property :accounting_service_group, String
property :log, ['use-partition-level-config','enable','disable']
property :logout_idle_timeout, Integer
property :account, String
property :logout_url, String
property :user_tag, String
property :server, String
property :redirect_hostname, String
property :logon, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/template/"
    get_url = "/axapi/v3/aam/authentication/template/%<name>s"
    max_session_time = new_resource.max_session_time
    accounting_server = new_resource.accounting_server
    saml_idp = new_resource.saml_idp
    cookie_max_age = new_resource.cookie_max_age
    uuid = new_resource.uuid
    local_logging = new_resource.local_logging
    auth_sess_mode = new_resource.auth_sess_mode
    service_group = new_resource.service_group
    ntype = new_resource.ntype
    modify_content_security_policy = new_resource.modify_content_security_policy
    relay = new_resource.relay
    saml_sp = new_resource.saml_sp
    cookie_domain = new_resource.cookie_domain
    cookie_domain_group = new_resource.cookie_domain_group
    forward_logout_disable = new_resource.forward_logout_disable
    accounting_service_group = new_resource.accounting_service_group
    log = new_resource.log
    logout_idle_timeout = new_resource.logout_idle_timeout
    account = new_resource.account
    a10_name = new_resource.a10_name
    logout_url = new_resource.logout_url
    user_tag = new_resource.user_tag
    server = new_resource.server
    redirect_hostname = new_resource.redirect_hostname
    logon = new_resource.logon

    params = { "template": {"max-session-time": max_session_time,
        "accounting-server": accounting_server,
        "saml-idp": saml_idp,
        "cookie-max-age": cookie_max_age,
        "uuid": uuid,
        "local-logging": local_logging,
        "auth-sess-mode": auth_sess_mode,
        "service-group": service_group,
        "type": ntype,
        "modify-content-security-policy": modify_content_security_policy,
        "relay": relay,
        "saml-sp": saml_sp,
        "cookie-domain": cookie_domain,
        "cookie-domain-group": cookie_domain_group,
        "forward-logout-disable": forward_logout_disable,
        "accounting-service-group": accounting_service_group,
        "log": log,
        "logout-idle-timeout": logout_idle_timeout,
        "account": account,
        "name": a10_name,
        "logout-url": logout_url,
        "user-tag": user_tag,
        "server": server,
        "redirect-hostname": redirect_hostname,
        "logon": logon,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/template/%<name>s"
    max_session_time = new_resource.max_session_time
    accounting_server = new_resource.accounting_server
    saml_idp = new_resource.saml_idp
    cookie_max_age = new_resource.cookie_max_age
    uuid = new_resource.uuid
    local_logging = new_resource.local_logging
    auth_sess_mode = new_resource.auth_sess_mode
    service_group = new_resource.service_group
    ntype = new_resource.ntype
    modify_content_security_policy = new_resource.modify_content_security_policy
    relay = new_resource.relay
    saml_sp = new_resource.saml_sp
    cookie_domain = new_resource.cookie_domain
    cookie_domain_group = new_resource.cookie_domain_group
    forward_logout_disable = new_resource.forward_logout_disable
    accounting_service_group = new_resource.accounting_service_group
    log = new_resource.log
    logout_idle_timeout = new_resource.logout_idle_timeout
    account = new_resource.account
    a10_name = new_resource.a10_name
    logout_url = new_resource.logout_url
    user_tag = new_resource.user_tag
    server = new_resource.server
    redirect_hostname = new_resource.redirect_hostname
    logon = new_resource.logon

    params = { "template": {"max-session-time": max_session_time,
        "accounting-server": accounting_server,
        "saml-idp": saml_idp,
        "cookie-max-age": cookie_max_age,
        "uuid": uuid,
        "local-logging": local_logging,
        "auth-sess-mode": auth_sess_mode,
        "service-group": service_group,
        "type": ntype,
        "modify-content-security-policy": modify_content_security_policy,
        "relay": relay,
        "saml-sp": saml_sp,
        "cookie-domain": cookie_domain,
        "cookie-domain-group": cookie_domain_group,
        "forward-logout-disable": forward_logout_disable,
        "accounting-service-group": accounting_service_group,
        "log": log,
        "logout-idle-timeout": logout_idle_timeout,
        "account": account,
        "name": a10_name,
        "logout-url": logout_url,
        "user-tag": user_tag,
        "server": server,
        "redirect-hostname": redirect_hostname,
        "logon": logon,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end