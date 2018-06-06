resource_name :a10_import_periodic_class_list

property :a10_name, String, name_property: true
property :uuid, String
property :use_mgmt_port, [true, false]
property :class_list, String,required: true
property :period, Integer
property :user_tag, String
property :remote_file, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/class-list/"
    get_url = "/axapi/v3/import-periodic/class-list/%<class-list>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    class_list = new_resource.class_list
    period = new_resource.period
    user_tag = new_resource.user_tag
    remote_file = new_resource.remote_file

    params = { "class-list": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "class-list": class_list,
        "period": period,
        "user-tag": user_tag,
        "remote-file": remote_file,} }

    params[:"class-list"].each do |k, v|
        if not v 
            params[:"class-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating class-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/class-list/%<class-list>s"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    class_list = new_resource.class_list
    period = new_resource.period
    user_tag = new_resource.user_tag
    remote_file = new_resource.remote_file

    params = { "class-list": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "class-list": class_list,
        "period": period,
        "user-tag": user_tag,
        "remote-file": remote_file,} }

    params[:"class-list"].each do |k, v|
        if not v
            params[:"class-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["class-list"].each do |k, v|
        if v != params[:"class-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating class-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/class-list/%<class-list>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list') do
            client.delete(url)
        end
    end
end