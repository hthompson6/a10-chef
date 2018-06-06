resource_name :a10_file_log_backup

property :a10_name, String, name_property: true
property :week, [true, false]
property :all, [true, false]
property :period, [true, false]
property :month, [true, false]
property :stats_data, [true, false]
property :expedite, [true, false]
property :date, Integer
property :day, [true, false]
property :file_handle, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file/"
    get_url = "/axapi/v3/file/log-backup"
    week = new_resource.week
    all = new_resource.all
    period = new_resource.period
    month = new_resource.month
    stats_data = new_resource.stats_data
    expedite = new_resource.expedite
    date = new_resource.date
    day = new_resource.day
    file_handle = new_resource.file_handle

    params = { "log-backup": {"week": week,
        "all": all,
        "period": period,
        "month": month,
        "stats-data": stats_data,
        "expedite": expedite,
        "date": date,
        "day": day,
        "file-handle": file_handle,} }

    params[:"log-backup"].each do |k, v|
        if not v 
            params[:"log-backup"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log-backup') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/log-backup"
    week = new_resource.week
    all = new_resource.all
    period = new_resource.period
    month = new_resource.month
    stats_data = new_resource.stats_data
    expedite = new_resource.expedite
    date = new_resource.date
    day = new_resource.day
    file_handle = new_resource.file_handle

    params = { "log-backup": {"week": week,
        "all": all,
        "period": period,
        "month": month,
        "stats-data": stats_data,
        "expedite": expedite,
        "date": date,
        "day": day,
        "file-handle": file_handle,} }

    params[:"log-backup"].each do |k, v|
        if not v
            params[:"log-backup"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log-backup"].each do |k, v|
        if v != params[:"log-backup"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log-backup') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file/log-backup"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log-backup') do
            client.delete(url)
        end
    end
end