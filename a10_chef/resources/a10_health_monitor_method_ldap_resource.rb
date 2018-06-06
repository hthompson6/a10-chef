resource_name :a10_health_monitor_method_ldap

property :a10_name, String, name_property: true
property :AcceptResRef, [true, false]
property :ldap_port, Integer
property :uuid, String
property :ldap_password_string, String
property :ldap_encrypted, String
property :BaseDN, String
property :ldap_password, [true, false]
property :ldap_binddn, String
property :ldap_query, String
property :ldap_security, ['overssl','StartTLS']
property :ldap, [true, false]
property :ldap_run_search, [true, false]
property :AcceptNotFound, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/ldap"
    AcceptResRef = new_resource.AcceptResRef
    ldap_port = new_resource.ldap_port
    uuid = new_resource.uuid
    ldap_password_string = new_resource.ldap_password_string
    ldap_encrypted = new_resource.ldap_encrypted
    BaseDN = new_resource.BaseDN
    ldap_password = new_resource.ldap_password
    ldap_binddn = new_resource.ldap_binddn
    ldap_query = new_resource.ldap_query
    ldap_security = new_resource.ldap_security
    ldap = new_resource.ldap
    ldap_run_search = new_resource.ldap_run_search
    AcceptNotFound = new_resource.AcceptNotFound

    params = { "ldap": {"AcceptResRef": AcceptResRef,
        "ldap-port": ldap_port,
        "uuid": uuid,
        "ldap-password-string": ldap_password_string,
        "ldap-encrypted": ldap_encrypted,
        "BaseDN": BaseDN,
        "ldap-password": ldap_password,
        "ldap-binddn": ldap_binddn,
        "ldap-query": ldap_query,
        "ldap-security": ldap_security,
        "ldap": ldap,
        "ldap-run-search": ldap_run_search,
        "AcceptNotFound": AcceptNotFound,} }

    params[:"ldap"].each do |k, v|
        if not v 
            params[:"ldap"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ldap') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ldap"
    AcceptResRef = new_resource.AcceptResRef
    ldap_port = new_resource.ldap_port
    uuid = new_resource.uuid
    ldap_password_string = new_resource.ldap_password_string
    ldap_encrypted = new_resource.ldap_encrypted
    BaseDN = new_resource.BaseDN
    ldap_password = new_resource.ldap_password
    ldap_binddn = new_resource.ldap_binddn
    ldap_query = new_resource.ldap_query
    ldap_security = new_resource.ldap_security
    ldap = new_resource.ldap
    ldap_run_search = new_resource.ldap_run_search
    AcceptNotFound = new_resource.AcceptNotFound

    params = { "ldap": {"AcceptResRef": AcceptResRef,
        "ldap-port": ldap_port,
        "uuid": uuid,
        "ldap-password-string": ldap_password_string,
        "ldap-encrypted": ldap_encrypted,
        "BaseDN": BaseDN,
        "ldap-password": ldap_password,
        "ldap-binddn": ldap_binddn,
        "ldap-query": ldap_query,
        "ldap-security": ldap_security,
        "ldap": ldap,
        "ldap-run-search": ldap_run_search,
        "AcceptNotFound": AcceptNotFound,} }

    params[:"ldap"].each do |k, v|
        if not v
            params[:"ldap"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ldap"].each do |k, v|
        if v != params[:"ldap"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ldap') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ldap"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ldap') do
            client.delete(url)
        end
    end
end