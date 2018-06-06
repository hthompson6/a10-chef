resource_name :a10_slb_template_policy_forward_policy_source_destination_web_category_list

property :a10_name, String, name_property: true
property :uuid, String
property :web_category_list, String,required: true
property :priority, Integer
property :sampling_enable, Array
property :a10_action, String
property :ntype, ['host','url']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/web-category-list/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/web-category-list/%<web-category-list>s"
    uuid = new_resource.uuid
    web_category_list = new_resource.web_category_list
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype

    params = { "web-category-list": {"uuid": uuid,
        "web-category-list": web_category_list,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "type": ntype,} }

    params[:"web-category-list"].each do |k, v|
        if not v 
            params[:"web-category-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating web-category-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/web-category-list/%<web-category-list>s"
    uuid = new_resource.uuid
    web_category_list = new_resource.web_category_list
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    ntype = new_resource.ntype

    params = { "web-category-list": {"uuid": uuid,
        "web-category-list": web_category_list,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "action": a10_action,
        "type": ntype,} }

    params[:"web-category-list"].each do |k, v|
        if not v
            params[:"web-category-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["web-category-list"].each do |k, v|
        if v != params[:"web-category-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating web-category-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s/destination/web-category-list/%<web-category-list>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting web-category-list') do
            client.delete(url)
        end
    end
end