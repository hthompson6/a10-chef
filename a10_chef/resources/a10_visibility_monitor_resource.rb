resource_name :a10_visibility_monitor

property :a10_name, String, name_property: true
property :primary_monitor, ['traffic','counters','xflow'],required: true
property :uuid, String
property :class_list, String
property :user_tag, String
property :index_sessions, [true, false]
property :traffic_key, ['source','dest','service','source-nat-ip']
property :secondary_monitor, ['source','dest','service','source-nat-ip']
property :index_sessions_type, ['per-cpu']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/monitor/"
    get_url = "/axapi/v3/visibility/monitor/%<primary-monitor>s"
    primary_monitor = new_resource.primary_monitor
    uuid = new_resource.uuid
    class_list = new_resource.class_list
    user_tag = new_resource.user_tag
    index_sessions = new_resource.index_sessions
    traffic_key = new_resource.traffic_key
    secondary_monitor = new_resource.secondary_monitor
    index_sessions_type = new_resource.index_sessions_type

    params = { "monitor": {"primary-monitor": primary_monitor,
        "uuid": uuid,
        "class-list": class_list,
        "user-tag": user_tag,
        "index-sessions": index_sessions,
        "traffic-key": traffic_key,
        "secondary-monitor": secondary_monitor,
        "index-sessions-type": index_sessions_type,} }

    params[:"monitor"].each do |k, v|
        if not v 
            params[:"monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/monitor/%<primary-monitor>s"
    primary_monitor = new_resource.primary_monitor
    uuid = new_resource.uuid
    class_list = new_resource.class_list
    user_tag = new_resource.user_tag
    index_sessions = new_resource.index_sessions
    traffic_key = new_resource.traffic_key
    secondary_monitor = new_resource.secondary_monitor
    index_sessions_type = new_resource.index_sessions_type

    params = { "monitor": {"primary-monitor": primary_monitor,
        "uuid": uuid,
        "class-list": class_list,
        "user-tag": user_tag,
        "index-sessions": index_sessions,
        "traffic-key": traffic_key,
        "secondary-monitor": secondary_monitor,
        "index-sessions-type": index_sessions_type,} }

    params[:"monitor"].each do |k, v|
        if not v
            params[:"monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["monitor"].each do |k, v|
        if v != params[:"monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/monitor/%<primary-monitor>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end