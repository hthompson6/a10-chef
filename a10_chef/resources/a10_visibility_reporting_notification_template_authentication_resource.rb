resource_name :a10_visibility_reporting_notification_template_authentication

property :a10_name, String, name_property: true
property :uuid, String
property :encrypted, String
property :relative_logoff_uri, String
property :auth_password_string, String
property :auth_password, [true, false]
property :relative_login_uri, String
property :auth_username, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/reporting/notification-template/%<name>s/"
    get_url = "/axapi/v3/visibility/reporting/notification-template/%<name>s/authentication"
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    relative_logoff_uri = new_resource.relative_logoff_uri
    auth_password_string = new_resource.auth_password_string
    auth_password = new_resource.auth_password
    relative_login_uri = new_resource.relative_login_uri
    auth_username = new_resource.auth_username

    params = { "authentication": {"uuid": uuid,
        "encrypted": encrypted,
        "relative-logoff-uri": relative_logoff_uri,
        "auth-password-string": auth_password_string,
        "auth-password": auth_password,
        "relative-login-uri": relative_login_uri,
        "auth-username": auth_username,} }

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
    url = "/axapi/v3/visibility/reporting/notification-template/%<name>s/authentication"
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    relative_logoff_uri = new_resource.relative_logoff_uri
    auth_password_string = new_resource.auth_password_string
    auth_password = new_resource.auth_password
    relative_login_uri = new_resource.relative_login_uri
    auth_username = new_resource.auth_username

    params = { "authentication": {"uuid": uuid,
        "encrypted": encrypted,
        "relative-logoff-uri": relative_logoff_uri,
        "auth-password-string": auth_password_string,
        "auth-password": auth_password,
        "relative-login-uri": relative_login_uri,
        "auth-username": auth_username,} }

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
    url = "/axapi/v3/visibility/reporting/notification-template/%<name>s/authentication"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting authentication') do
            client.delete(url)
        end
    end
end