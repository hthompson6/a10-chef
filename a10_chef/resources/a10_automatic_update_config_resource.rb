resource_name :a10_automatic_update_config

property :a10_name, String, name_property: true
property :day_time, String
property :uuid, String
property :schedule, [true, false]
property :feature_name, ['app-fw'],required: true
property :week_day, ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']
property :daily, [true, false]
property :week_time, String
property :weekly, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/automatic-update/config/"
    get_url = "/axapi/v3/automatic-update/config/%<feature-name>s"
    day_time = new_resource.day_time
    uuid = new_resource.uuid
    schedule = new_resource.schedule
    feature_name = new_resource.feature_name
    week_day = new_resource.week_day
    daily = new_resource.daily
    week_time = new_resource.week_time
    weekly = new_resource.weekly

    params = { "config": {"day-time": day_time,
        "uuid": uuid,
        "schedule": schedule,
        "feature-name": feature_name,
        "week-day": week_day,
        "daily": daily,
        "week-time": week_time,
        "weekly": weekly,} }

    params[:"config"].each do |k, v|
        if not v 
            params[:"config"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating config') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/config/%<feature-name>s"
    day_time = new_resource.day_time
    uuid = new_resource.uuid
    schedule = new_resource.schedule
    feature_name = new_resource.feature_name
    week_day = new_resource.week_day
    daily = new_resource.daily
    week_time = new_resource.week_time
    weekly = new_resource.weekly

    params = { "config": {"day-time": day_time,
        "uuid": uuid,
        "schedule": schedule,
        "feature-name": feature_name,
        "week-day": week_day,
        "daily": daily,
        "week-time": week_time,
        "weekly": weekly,} }

    params[:"config"].each do |k, v|
        if not v
            params[:"config"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["config"].each do |k, v|
        if v != params[:"config"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating config') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/config/%<feature-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting config') do
            client.delete(url)
        end
    end
end