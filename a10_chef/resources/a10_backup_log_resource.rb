resource_name :a10_backup_log

property :a10_name, String, name_property: true
property :week, [true, false]
property :all, [true, false]
property :password, String
property :remote_file, String
property :use_mgmt_port, [true, false]
property :period, [true, false]
property :month, [true, false]
property :stats_data, [true, false]
property :date, Integer
property :store_name, String
property :day, [true, false]
property :expedite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/backup/"
    get_url = "/axapi/v3/backup/log"
    week = new_resource.week
    all = new_resource.all
    password = new_resource.password
    remote_file = new_resource.remote_file
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    month = new_resource.month
    stats_data = new_resource.stats_data
    date = new_resource.date
    store_name = new_resource.store_name
    day = new_resource.day
    expedite = new_resource.expedite

    params = { "log": {"week": week,
        "all": all,
        "password": password,
        "remote-file": remote_file,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "month": month,
        "stats-data": stats_data,
        "date": date,
        "store-name": store_name,
        "day": day,
        "expedite": expedite,} }

    params[:"log"].each do |k, v|
        if not v 
            params[:"log"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/log"
    week = new_resource.week
    all = new_resource.all
    password = new_resource.password
    remote_file = new_resource.remote_file
    use_mgmt_port = new_resource.use_mgmt_port
    period = new_resource.period
    month = new_resource.month
    stats_data = new_resource.stats_data
    date = new_resource.date
    store_name = new_resource.store_name
    day = new_resource.day
    expedite = new_resource.expedite

    params = { "log": {"week": week,
        "all": all,
        "password": password,
        "remote-file": remote_file,
        "use-mgmt-port": use_mgmt_port,
        "period": period,
        "month": month,
        "stats-data": stats_data,
        "date": date,
        "store-name": store_name,
        "day": day,
        "expedite": expedite,} }

    params[:"log"].each do |k, v|
        if not v
            params[:"log"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log"].each do |k, v|
        if v != params[:"log"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/log"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log') do
            client.delete(url)
        end
    end
end