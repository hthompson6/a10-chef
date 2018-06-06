resource_name :a10_shutdown

property :a10_name, String, name_property: true
property :day_of_month, Integer
property :reason_3, String
property :reason_2, String
property :time, String
property :month_2, ['January','February','March','April','May','June','July','August','September','October','November','December']
property :month, ['January','February','March','April','May','June','July','August','September','October','November','December']
property :reason, String
property :at, [true, false]
property :nin, String
property :cancel, [true, false]
property :day_of_month_2, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/shutdown"
    day_of_month = new_resource.day_of_month
    reason_3 = new_resource.reason_3
    reason_2 = new_resource.reason_2
    time = new_resource.time
    month_2 = new_resource.month_2
    month = new_resource.month
    reason = new_resource.reason
    at = new_resource.at
    nin = new_resource.nin
    cancel = new_resource.cancel
    day_of_month_2 = new_resource.day_of_month_2

    params = { "shutdown": {"day-of-month": day_of_month,
        "reason-3": reason_3,
        "reason-2": reason_2,
        "time": time,
        "month-2": month_2,
        "month": month,
        "reason": reason,
        "at": at,
        "in": nin,
        "cancel": cancel,
        "day-of-month-2": day_of_month_2,} }

    params[:"shutdown"].each do |k, v|
        if not v 
            params[:"shutdown"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating shutdown') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/shutdown"
    day_of_month = new_resource.day_of_month
    reason_3 = new_resource.reason_3
    reason_2 = new_resource.reason_2
    time = new_resource.time
    month_2 = new_resource.month_2
    month = new_resource.month
    reason = new_resource.reason
    at = new_resource.at
    nin = new_resource.nin
    cancel = new_resource.cancel
    day_of_month_2 = new_resource.day_of_month_2

    params = { "shutdown": {"day-of-month": day_of_month,
        "reason-3": reason_3,
        "reason-2": reason_2,
        "time": time,
        "month-2": month_2,
        "month": month,
        "reason": reason,
        "at": at,
        "in": nin,
        "cancel": cancel,
        "day-of-month-2": day_of_month_2,} }

    params[:"shutdown"].each do |k, v|
        if not v
            params[:"shutdown"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["shutdown"].each do |k, v|
        if v != params[:"shutdown"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating shutdown') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/shutdown"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting shutdown') do
            client.delete(url)
        end
    end
end