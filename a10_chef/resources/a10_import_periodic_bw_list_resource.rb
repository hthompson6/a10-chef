resource_name :a10_import_periodic_bw_list

property :a10_name, String, name_property: true
property :use_mgmt_port, [true, false]
property :period, Integer
property :uuid, String
property :remote_file, String
property :bw_list, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/bw-list/"
    get_url = "/axapi/v3/import-periodic/bw-list/%<bw-list>s"
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    bw_list = new_resource.bw_list

    params = { "bw-list": {"use-mgmt-port": use_mgmt_port,
        "period": period,
        "uuid": uuid,
        "remote-file": remote_file,
        "bw-list": bw_list,} }

    params[:"bw-list"].each do |k, v|
        if not v 
            params[:"bw-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bw-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/bw-list/%<bw-list>s"
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    bw_list = new_resource.bw_list

    params = { "bw-list": {"use-mgmt-port": use_mgmt_port,
        "period": period,
        "uuid": uuid,
        "remote-file": remote_file,
        "bw-list": bw_list,} }

    params[:"bw-list"].each do |k, v|
        if not v
            params[:"bw-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bw-list"].each do |k, v|
        if v != params[:"bw-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bw-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/bw-list/%<bw-list>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bw-list') do
            client.delete(url)
        end
    end
end