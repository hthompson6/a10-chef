resource_name :a10_aam_authentication_server_ldap_instance

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :protocol, ['ldap','ldaps','starttls']
property :encrypted, String
property :port, Integer
property :ldaps_conn_reuse_idle_timeout, Integer
property :port_hm, String
property :uuid, String
property :admin_dn, String
property :default_domain, String
property :auth_type, ['ad','open-ldap']
property :admin_secret, [true, false]
property :pwdmaxage, Integer
property :health_check_string, String
property :derive_bind_dn, Hash
property :prompt_pw_change_before_exp, Integer
property :base, String
property :secret_string, String
property :port_hm_disable, [true, false]
property :host, Hash
property :ca_cert, String
property :bind_with_dn, [true, false]
property :sampling_enable, Array
property :dn_attribute, String
property :timeout, Integer
property :health_check, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/ldap/instance/"
    get_url = "/axapi/v3/aam/authentication/server/ldap/instance/%<name>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    encrypted = new_resource.encrypted
    port = new_resource.port
    ldaps_conn_reuse_idle_timeout = new_resource.ldaps_conn_reuse_idle_timeout
    port_hm = new_resource.port_hm
    uuid = new_resource.uuid
    admin_dn = new_resource.admin_dn
    default_domain = new_resource.default_domain
    auth_type = new_resource.auth_type
    admin_secret = new_resource.admin_secret
    pwdmaxage = new_resource.pwdmaxage
    health_check_string = new_resource.health_check_string
    derive_bind_dn = new_resource.derive_bind_dn
    prompt_pw_change_before_exp = new_resource.prompt_pw_change_before_exp
    base = new_resource.base
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name
    port_hm_disable = new_resource.port_hm_disable
    host = new_resource.host
    ca_cert = new_resource.ca_cert
    bind_with_dn = new_resource.bind_with_dn
    sampling_enable = new_resource.sampling_enable
    dn_attribute = new_resource.dn_attribute
    timeout = new_resource.timeout
    health_check = new_resource.health_check

    params = { "instance": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "encrypted": encrypted,
        "port": port,
        "ldaps-conn-reuse-idle-timeout": ldaps_conn_reuse_idle_timeout,
        "port-hm": port_hm,
        "uuid": uuid,
        "admin-dn": admin_dn,
        "default-domain": default_domain,
        "auth-type": auth_type,
        "admin-secret": admin_secret,
        "pwdmaxage": pwdmaxage,
        "health-check-string": health_check_string,
        "derive-bind-dn": derive_bind_dn,
        "prompt-pw-change-before-exp": prompt_pw_change_before_exp,
        "base": base,
        "secret-string": secret_string,
        "name": a10_name,
        "port-hm-disable": port_hm_disable,
        "host": host,
        "ca-cert": ca_cert,
        "bind-with-dn": bind_with_dn,
        "sampling-enable": sampling_enable,
        "dn-attribute": dn_attribute,
        "timeout": timeout,
        "health-check": health_check,} }

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
    url = "/axapi/v3/aam/authentication/server/ldap/instance/%<name>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    encrypted = new_resource.encrypted
    port = new_resource.port
    ldaps_conn_reuse_idle_timeout = new_resource.ldaps_conn_reuse_idle_timeout
    port_hm = new_resource.port_hm
    uuid = new_resource.uuid
    admin_dn = new_resource.admin_dn
    default_domain = new_resource.default_domain
    auth_type = new_resource.auth_type
    admin_secret = new_resource.admin_secret
    pwdmaxage = new_resource.pwdmaxage
    health_check_string = new_resource.health_check_string
    derive_bind_dn = new_resource.derive_bind_dn
    prompt_pw_change_before_exp = new_resource.prompt_pw_change_before_exp
    base = new_resource.base
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name
    port_hm_disable = new_resource.port_hm_disable
    host = new_resource.host
    ca_cert = new_resource.ca_cert
    bind_with_dn = new_resource.bind_with_dn
    sampling_enable = new_resource.sampling_enable
    dn_attribute = new_resource.dn_attribute
    timeout = new_resource.timeout
    health_check = new_resource.health_check

    params = { "instance": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "encrypted": encrypted,
        "port": port,
        "ldaps-conn-reuse-idle-timeout": ldaps_conn_reuse_idle_timeout,
        "port-hm": port_hm,
        "uuid": uuid,
        "admin-dn": admin_dn,
        "default-domain": default_domain,
        "auth-type": auth_type,
        "admin-secret": admin_secret,
        "pwdmaxage": pwdmaxage,
        "health-check-string": health_check_string,
        "derive-bind-dn": derive_bind_dn,
        "prompt-pw-change-before-exp": prompt_pw_change_before_exp,
        "base": base,
        "secret-string": secret_string,
        "name": a10_name,
        "port-hm-disable": port_hm_disable,
        "host": host,
        "ca-cert": ca_cert,
        "bind-with-dn": bind_with_dn,
        "sampling-enable": sampling_enable,
        "dn-attribute": dn_attribute,
        "timeout": timeout,
        "health-check": health_check,} }

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
    url = "/axapi/v3/aam/authentication/server/ldap/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end