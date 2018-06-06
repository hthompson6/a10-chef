resource_name :a10_import_periodic_class_list_convert

property :a10_name, String, name_property: true
property :class_list_type, ['ac','ipv4','ipv6','string','string-case-insensitive']
property :use_mgmt_port, [true, false]
property :period, Integer
property :remote_file, String
property :class_list_convert, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/class-list-convert/"
    get_url = "/axapi/v3/import-periodic/class-list-convert/%<class-list-convert>s"
    class_list_type = new_resource.class_list_type
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    remote_file = new_resource.remote_file
    class_list_convert = new_resource.class_list_convert
    uuid = new_resource.uuid

    params = { "class-list-convert": {"class-list-type": class_list_type,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "remote-file": remote_file,
        "class-list-convert": class_list_convert,
        "uuid": uuid,} }

    params[:"class-list-convert"].each do |k, v|
        if not v 
            params[:"class-list-convert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating class-list-convert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/class-list-convert/%<class-list-convert>s"
    class_list_type = new_resource.class_list_type
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    remote_file = new_resource.remote_file
    class_list_convert = new_resource.class_list_convert
    uuid = new_resource.uuid

    params = { "class-list-convert": {"class-list-type": class_list_type,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "remote-file": remote_file,
        "class-list-convert": class_list_convert,
        "uuid": uuid,} }

    params[:"class-list-convert"].each do |k, v|
        if not v
            params[:"class-list-convert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["class-list-convert"].each do |k, v|
        if v != params[:"class-list-convert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating class-list-convert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/class-list-convert/%<class-list-convert>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list-convert') do
            client.delete(url)
        end
    end
end