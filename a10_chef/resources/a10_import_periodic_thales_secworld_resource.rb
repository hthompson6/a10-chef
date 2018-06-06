resource_name :a10_import_periodic_thales_secworld

property :a10_name, String, name_property: true
property :uuid, String
property :use_mgmt_port, [true, false]
property :period, Integer
property :remote_file, String
property :thales_secworld, String,required: true
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/thales-secworld/"
    get_url = "/axapi/v3/import-periodic/thales-secworld/%<thales-secworld>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    remote_file = new_resource.remote_file
    thales_secworld = new_resource.thales_secworld
    overwrite = new_resource.overwrite

    params = { "thales-secworld": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "remote-file": remote_file,
        "thales-secworld": thales_secworld,
        "overwrite": overwrite,} }

    params[:"thales-secworld"].each do |k, v|
        if not v 
            params[:"thales-secworld"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating thales-secworld') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/thales-secworld/%<thales-secworld>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    remote_file = new_resource.remote_file
    thales_secworld = new_resource.thales_secworld
    overwrite = new_resource.overwrite

    params = { "thales-secworld": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "remote-file": remote_file,
        "thales-secworld": thales_secworld,
        "overwrite": overwrite,} }

    params[:"thales-secworld"].each do |k, v|
        if not v
            params[:"thales-secworld"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["thales-secworld"].each do |k, v|
        if v != params[:"thales-secworld"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating thales-secworld') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/thales-secworld/%<thales-secworld>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting thales-secworld') do
            client.delete(url)
        end
    end
end