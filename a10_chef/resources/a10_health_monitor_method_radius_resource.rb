resource_name :a10_health_monitor_method_radius

property :a10_name, String, name_property: true
property :radius_username, String
property :radius_password_string, String
property :radius_encrypted, String
property :radius_response_code, String
property :radius_expect, [true, false]
property :radius, [true, false]
property :radius_secret, String
property :radius_password, [true, false]
property :radius_port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/radius"
    radius_username = new_resource.radius_username
    radius_password_string = new_resource.radius_password_string
    radius_encrypted = new_resource.radius_encrypted
    radius_response_code = new_resource.radius_response_code
    radius_expect = new_resource.radius_expect
    radius = new_resource.radius
    radius_secret = new_resource.radius_secret
    radius_password = new_resource.radius_password
    radius_port = new_resource.radius_port
    uuid = new_resource.uuid

    params = { "radius": {"radius-username": radius_username,
        "radius-password-string": radius_password_string,
        "radius-encrypted": radius_encrypted,
        "radius-response-code": radius_response_code,
        "radius-expect": radius_expect,
        "radius": radius,
        "radius-secret": radius_secret,
        "radius-password": radius_password,
        "radius-port": radius_port,
        "uuid": uuid,} }

    params[:"radius"].each do |k, v|
        if not v 
            params[:"radius"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating radius') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/radius"
    radius_username = new_resource.radius_username
    radius_password_string = new_resource.radius_password_string
    radius_encrypted = new_resource.radius_encrypted
    radius_response_code = new_resource.radius_response_code
    radius_expect = new_resource.radius_expect
    radius = new_resource.radius
    radius_secret = new_resource.radius_secret
    radius_password = new_resource.radius_password
    radius_port = new_resource.radius_port
    uuid = new_resource.uuid

    params = { "radius": {"radius-username": radius_username,
        "radius-password-string": radius_password_string,
        "radius-encrypted": radius_encrypted,
        "radius-response-code": radius_response_code,
        "radius-expect": radius_expect,
        "radius": radius,
        "radius-secret": radius_secret,
        "radius-password": radius_password,
        "radius-port": radius_port,
        "uuid": uuid,} }

    params[:"radius"].each do |k, v|
        if not v
            params[:"radius"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["radius"].each do |k, v|
        if v != params[:"radius"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating radius') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/radius"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting radius') do
            client.delete(url)
        end
    end
end