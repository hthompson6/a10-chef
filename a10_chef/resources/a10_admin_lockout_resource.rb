resource_name :a10_admin_lockout

property :a10_name, String, name_property: true
property :duration, Integer
property :threshold, Integer
property :enable, [true, false]
property :uuid, String
property :reset_time, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/admin-lockout"
    duration = new_resource.duration
    threshold = new_resource.threshold
    enable = new_resource.enable
    uuid = new_resource.uuid
    reset_time = new_resource.reset_time

    params = { "admin-lockout": {"duration": duration,
        "threshold": threshold,
        "enable": enable,
        "uuid": uuid,
        "reset-time": reset_time,} }

    params[:"admin-lockout"].each do |k, v|
        if not v 
            params[:"admin-lockout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating admin-lockout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin-lockout"
    duration = new_resource.duration
    threshold = new_resource.threshold
    enable = new_resource.enable
    uuid = new_resource.uuid
    reset_time = new_resource.reset_time

    params = { "admin-lockout": {"duration": duration,
        "threshold": threshold,
        "enable": enable,
        "uuid": uuid,
        "reset-time": reset_time,} }

    params[:"admin-lockout"].each do |k, v|
        if not v
            params[:"admin-lockout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["admin-lockout"].each do |k, v|
        if v != params[:"admin-lockout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating admin-lockout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin-lockout"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting admin-lockout') do
            client.delete(url)
        end
    end
end