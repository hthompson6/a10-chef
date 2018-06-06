resource_name :a10_event_partition

property :a10_name, String, name_property: true
property :vnp_events, ['part-create','part-del'],required: true
property :logging, ['on','off']
property :email, ['on','off']
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/event/partition/"
    get_url = "/axapi/v3/event/partition/%<vnp-events>s"
    vnp_events = new_resource.vnp_events
    logging = new_resource.logging
    email = new_resource.email
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "partition": {"vnp-events": vnp_events,
        "logging": logging,
        "email": email,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"partition"].each do |k, v|
        if not v 
            params[:"partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/event/partition/%<vnp-events>s"
    vnp_events = new_resource.vnp_events
    logging = new_resource.logging
    email = new_resource.email
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "partition": {"vnp-events": vnp_events,
        "logging": logging,
        "email": email,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"partition"].each do |k, v|
        if not v
            params[:"partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["partition"].each do |k, v|
        if v != params[:"partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/event/partition/%<vnp-events>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting partition') do
            client.delete(url)
        end
    end
end