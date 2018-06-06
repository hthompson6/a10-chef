resource_name :a10_import_periodic_file_inspection_bw_list

property :a10_name, String, name_property: true
property :period, Integer
property :use_mgmt_port, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/"
    get_url = "/axapi/v3/import-periodic/file-inspection-bw-list"
    period = new_resource.period
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid

    params = { "file-inspection-bw-list": {"period": period,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,} }

    params[:"file-inspection-bw-list"].each do |k, v|
        if not v 
            params[:"file-inspection-bw-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating file-inspection-bw-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/file-inspection-bw-list"
    period = new_resource.period
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid

    params = { "file-inspection-bw-list": {"period": period,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,} }

    params[:"file-inspection-bw-list"].each do |k, v|
        if not v
            params[:"file-inspection-bw-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["file-inspection-bw-list"].each do |k, v|
        if v != params[:"file-inspection-bw-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating file-inspection-bw-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/file-inspection-bw-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting file-inspection-bw-list') do
            client.delete(url)
        end
    end
end