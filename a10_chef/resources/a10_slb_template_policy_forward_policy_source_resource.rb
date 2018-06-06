resource_name :a10_slb_template_policy_forward_policy_source

property :a10_name, String, name_property: true
property :match_any, [true, false]
property :match_authorize_policy, String
property :destination, Hash
property :user_tag, String
property :priority, Integer
property :sampling_enable, Array
property :match_class_list, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s"
    match_any = new_resource.match_any
    a10_name = new_resource.a10_name
    match_authorize_policy = new_resource.match_authorize_policy
    destination = new_resource.destination
    user_tag = new_resource.user_tag
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    match_class_list = new_resource.match_class_list
    uuid = new_resource.uuid

    params = { "source": {"match-any": match_any,
        "name": a10_name,
        "match-authorize-policy": match_authorize_policy,
        "destination": destination,
        "user-tag": user_tag,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "match-class-list": match_class_list,
        "uuid": uuid,} }

    params[:"source"].each do |k, v|
        if not v 
            params[:"source"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating source') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s"
    match_any = new_resource.match_any
    a10_name = new_resource.a10_name
    match_authorize_policy = new_resource.match_authorize_policy
    destination = new_resource.destination
    user_tag = new_resource.user_tag
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    match_class_list = new_resource.match_class_list
    uuid = new_resource.uuid

    params = { "source": {"match-any": match_any,
        "name": a10_name,
        "match-authorize-policy": match_authorize_policy,
        "destination": destination,
        "user-tag": user_tag,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "match-class-list": match_class_list,
        "uuid": uuid,} }

    params[:"source"].each do |k, v|
        if not v
            params[:"source"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["source"].each do |k, v|
        if v != params[:"source"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating source') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/source/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting source') do
            client.delete(url)
        end
    end
end