resource_name :a10_acos_events_message_selector_rule

property :a10_name, String, name_property: true
property :index, Integer,required: true
property :message_id, String
property :uuid, String
property :severity_val, ['emergency','alert','critical','error','warning','notification','information','debugging']
property :user_tag, String
property :a10_action, ['send','drop']
property :message_id_scope, ['all','node-only','children-only']
property :severity_oper, ['equal-and-higher','equal']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/message-selector/%<name>s/rule/"
    get_url = "/axapi/v3/acos-events/message-selector/%<name>s/rule/%<index>s"
    index = new_resource.index
    message_id = new_resource.message_id
    uuid = new_resource.uuid
    severity_val = new_resource.severity_val
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    message_id_scope = new_resource.message_id_scope
    severity_oper = new_resource.severity_oper

    params = { "rule": {"index": index,
        "message-id": message_id,
        "uuid": uuid,
        "severity-val": severity_val,
        "user-tag": user_tag,
        "action": a10_action,
        "message-id-scope": message_id_scope,
        "severity-oper": severity_oper,} }

    params[:"rule"].each do |k, v|
        if not v 
            params[:"rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-selector/%<name>s/rule/%<index>s"
    index = new_resource.index
    message_id = new_resource.message_id
    uuid = new_resource.uuid
    severity_val = new_resource.severity_val
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    message_id_scope = new_resource.message_id_scope
    severity_oper = new_resource.severity_oper

    params = { "rule": {"index": index,
        "message-id": message_id,
        "uuid": uuid,
        "severity-val": severity_val,
        "user-tag": user_tag,
        "action": a10_action,
        "message-id-scope": message_id_scope,
        "severity-oper": severity_oper,} }

    params[:"rule"].each do |k, v|
        if not v
            params[:"rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rule"].each do |k, v|
        if v != params[:"rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-selector/%<name>s/rule/%<index>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rule') do
            client.delete(url)
        end
    end
end