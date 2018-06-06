resource_name :a10_slb_template_policy_forward_policy_source_destination_class_list

property :a10_name, String, name_property: true
property :uuid, String
property :dest_class_list, String,required: true
property :priority, Integer
property :sampling_enable, Array
property :a10_action, String
property :ntype, ['host','url','ip']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/class-list/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/class-list/%<dest-class-list>s"
    uuid = new_resource.uuid
    dest_class_list = new_resource.dest_class_list
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype

    params = { "class-list": {"uuid": uuid,
        "dest-class-list": dest_class_list,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "type": ntype,} }

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
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/class-list/%<dest-class-list>s"
    uuid = new_resource.uuid
    dest_class_list = new_resource.dest_class_list
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype

    params = { "class-list": {"uuid": uuid,
        "dest-class-list": dest_class_list,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "type": ntype,} }

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
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/class-list/%<dest-class-list>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list') do
            client.delete(url)
        end
    end
end