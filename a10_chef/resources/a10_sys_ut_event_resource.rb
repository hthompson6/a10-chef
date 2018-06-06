resource_name :a10_sys_ut_event

property :a10_name, String, name_property: true
property :action_list, Array
property :event_number, Integer,required: true
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s"
    action_list = new_resource.action_list
    event_number = new_resource.event_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "event": {"action-list": action_list,
        "event-number": event_number,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"event"].each do |k, v|
        if not v 
            params[:"event"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating event') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s"
    action_list = new_resource.action_list
    event_number = new_resource.event_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "event": {"action-list": action_list,
        "event-number": event_number,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"event"].each do |k, v|
        if not v
            params[:"event"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["event"].each do |k, v|
        if v != params[:"event"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating event') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting event') do
            client.delete(url)
        end
    end
end