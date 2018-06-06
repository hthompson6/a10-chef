resource_name :a10_import_periodic_auth_portal

property :a10_name, String, name_property: true
property :use_mgmt_port, [true, false]
property :auth_portal, String,required: true
property :uuid, String
property :remote_file, String
property :period, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/auth-portal/"
    get_url = "/axapi/v3/import-periodic/auth-portal/%<auth-portal>s"
    use_mgmt_port = new_resource.use_mgmt_port
    auth_portal = new_resource.auth_portal
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "auth-portal": {"use-mgmt-port": use_mgmt_port,
        "auth-portal": auth_portal,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

    params[:"auth-portal"].each do |k, v|
        if not v 
            params[:"auth-portal"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auth-portal') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/auth-portal/%<auth-portal>s"
    use_mgmt_port = new_resource.use_mgmt_port
    auth_portal = new_resource.auth_portal
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "auth-portal": {"use-mgmt-port": use_mgmt_port,
        "auth-portal": auth_portal,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

    params[:"auth-portal"].each do |k, v|
        if not v
            params[:"auth-portal"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auth-portal"].each do |k, v|
        if v != params[:"auth-portal"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auth-portal') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/auth-portal/%<auth-portal>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth-portal') do
            client.delete(url)
        end
    end
end