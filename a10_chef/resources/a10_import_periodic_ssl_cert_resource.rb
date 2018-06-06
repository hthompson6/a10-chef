resource_name :a10_import_periodic_ssl_cert

property :a10_name, String, name_property: true
property :use_mgmt_port, [true, false]
property :period, Integer
property :uuid, String
property :remote_file, String
property :ssl_cert, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/ssl-cert/"
    get_url = "/axapi/v3/import-periodic/ssl-cert/%<ssl-cert>s"
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    ssl_cert = new_resource.ssl_cert

    params = { "ssl-cert": {"use-mgmt-port": use_mgmt_port,
        "period": period,
        "uuid": uuid,
        "remote-file": remote_file,
        "ssl-cert": ssl_cert,} }

    params[:"ssl-cert"].each do |k, v|
        if not v 
            params[:"ssl-cert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssl-cert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/ssl-cert/%<ssl-cert>s"
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    ssl_cert = new_resource.ssl_cert

    params = { "ssl-cert": {"use-mgmt-port": use_mgmt_port,
        "period": period,
        "uuid": uuid,
        "remote-file": remote_file,
        "ssl-cert": ssl_cert,} }

    params[:"ssl-cert"].each do |k, v|
        if not v
            params[:"ssl-cert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssl-cert"].each do |k, v|
        if v != params[:"ssl-cert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssl-cert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/ssl-cert/%<ssl-cert>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssl-cert') do
            client.delete(url)
        end
    end
end