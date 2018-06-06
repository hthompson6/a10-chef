resource_name :a10_acos_events_message_selector

property :a10_name, String, name_property: true
property :user_tag, String
property :rule_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/message-selector/"
    get_url = "/axapi/v3/acos-events/message-selector/%<name>s"
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    rule_list = new_resource.rule_list
    uuid = new_resource.uuid

    params = { "message-selector": {"user-tag": user_tag,
        "name": a10_name,
        "rule-list": rule_list,
        "uuid": uuid,} }

    params[:"message-selector"].each do |k, v|
        if not v 
            params[:"message-selector"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating message-selector') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-selector/%<name>s"
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    rule_list = new_resource.rule_list
    uuid = new_resource.uuid

    params = { "message-selector": {"user-tag": user_tag,
        "name": a10_name,
        "rule-list": rule_list,
        "uuid": uuid,} }

    params[:"message-selector"].each do |k, v|
        if not v
            params[:"message-selector"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["message-selector"].each do |k, v|
        if v != params[:"message-selector"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating message-selector') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-selector/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting message-selector') do
            client.delete(url)
        end
    end
end