resource_name :a10_import_periodic_thales_kmdata

property :a10_name, String, name_property: true
property :uuid, String
property :use_mgmt_port, [true, false]
property :thales_kmdata, String,required: true
property :period, Integer
property :remote_file, String
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/thales-kmdata/"
    get_url = "/axapi/v3/import-periodic/thales-kmdata/%<thales-kmdata>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    thales_kmdata = new_resource.thales_kmdata
    period = new_resource.period
    remote_file = new_resource.remote_file
    overwrite = new_resource.overwrite

    params = { "thales-kmdata": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "thales-kmdata": thales_kmdata,
        "period": period,
        "remote-file": remote_file,
        "overwrite": overwrite,} }

    params[:"thales-kmdata"].each do |k, v|
        if not v 
            params[:"thales-kmdata"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating thales-kmdata') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/thales-kmdata/%<thales-kmdata>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    thales_kmdata = new_resource.thales_kmdata
    period = new_resource.period
    remote_file = new_resource.remote_file
    overwrite = new_resource.overwrite

    params = { "thales-kmdata": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "thales-kmdata": thales_kmdata,
        "period": period,
        "remote-file": remote_file,
        "overwrite": overwrite,} }

    params[:"thales-kmdata"].each do |k, v|
        if not v
            params[:"thales-kmdata"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["thales-kmdata"].each do |k, v|
        if v != params[:"thales-kmdata"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating thales-kmdata') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/thales-kmdata/%<thales-kmdata>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting thales-kmdata') do
            client.delete(url)
        end
    end
end