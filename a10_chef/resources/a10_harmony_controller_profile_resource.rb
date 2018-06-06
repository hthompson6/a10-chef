resource_name :a10_harmony_controller_profile

property :a10_name, String, name_property: true
property :user_name, String
property :uuid, String
property :use_mgmt_port, [true, false]
property :region, String
property :metrics_export_interval, Integer
property :availability_zone, String
property :port, Integer
property :thunder_mgmt_ip, String
property :host, String
property :password_encrypted, String
property :a10_provider, String
property :a10_action, ['register','deregister']
property :secret_value, String
property :log_rate, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/harmony-controller/"
    get_url = "/axapi/v3/harmony-controller/profile"
    user_name = new_resource.user_name
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    region = new_resource.region
    metrics_export_interval = new_resource.metrics_export_interval
    availability_zone = new_resource.availability_zone
    port = new_resource.port
    thunder_mgmt_ip = new_resource.thunder_mgmt_ip
    host = new_resource.host
    password_encrypted = new_resource.password_encrypted
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    secret_value = new_resource.secret_value
    log_rate = new_resource.log_rate

    params = { "profile": {"user-name": user_name,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "region": region,
        "metrics-export-interval": metrics_export_interval,
        "availability-zone": availability_zone,
        "port": port,
        "thunder-mgmt-ip": thunder_mgmt_ip,
        "host": host,
        "password-encrypted": password_encrypted,
        "provider": a10_provider,
        "action": a10_action,
        "secret-value": secret_value,
        "log-rate": log_rate,} }

    params[:"profile"].each do |k, v|
        if not v 
            params[:"profile"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating profile') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/harmony-controller/profile"
    user_name = new_resource.user_name
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    region = new_resource.region
    metrics_export_interval = new_resource.metrics_export_interval
    availability_zone = new_resource.availability_zone
    port = new_resource.port
    thunder_mgmt_ip = new_resource.thunder_mgmt_ip
    host = new_resource.host
    password_encrypted = new_resource.password_encrypted
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    secret_value = new_resource.secret_value
    log_rate = new_resource.log_rate

    params = { "profile": {"user-name": user_name,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "region": region,
        "metrics-export-interval": metrics_export_interval,
        "availability-zone": availability_zone,
        "port": port,
        "thunder-mgmt-ip": thunder_mgmt_ip,
        "host": host,
        "password-encrypted": password_encrypted,
        "provider": a10_provider,
        "action": a10_action,
        "secret-value": secret_value,
        "log-rate": log_rate,} }

    params[:"profile"].each do |k, v|
        if not v
            params[:"profile"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["profile"].each do |k, v|
        if v != params[:"profile"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating profile') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/harmony-controller/profile"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting profile') do
            client.delete(url)
        end
    end
end