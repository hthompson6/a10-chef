resource_name :a10_acos_events_message_id

property :a10_name, String, name_property: true
property :log_msg, String,required: true
property :property, Hash
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/message-id/"
    get_url = "/axapi/v3/acos-events/message-id/%<log-msg>s"
    log_msg = new_resource.log_msg
    property = new_resource.property
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "message-id": {"log-msg": log_msg,
        "property": property,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"message-id"].each do |k, v|
        if not v 
            params[:"message-id"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating message-id') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-id/%<log-msg>s"
    log_msg = new_resource.log_msg
    property = new_resource.property
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "message-id": {"log-msg": log_msg,
        "property": property,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"message-id"].each do |k, v|
        if not v
            params[:"message-id"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["message-id"].each do |k, v|
        if v != params[:"message-id"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating message-id') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-id/%<log-msg>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting message-id') do
            client.delete(url)
        end
    end
end