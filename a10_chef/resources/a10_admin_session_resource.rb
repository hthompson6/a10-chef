resource_name :a10_admin_session

property :a10_name, String, name_property: true
property :clear, [true, false]
property :all, [true, false]
property :sid, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/admin-session"
    clear = new_resource.clear
    all = new_resource.all
    sid = new_resource.sid

    params = { "admin-session": {"clear": clear,
        "all": all,
        "sid": sid,} }

    params[:"admin-session"].each do |k, v|
        if not v 
            params[:"admin-session"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating admin-session') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin-session"
    clear = new_resource.clear
    all = new_resource.all
    sid = new_resource.sid

    params = { "admin-session": {"clear": clear,
        "all": all,
        "sid": sid,} }

    params[:"admin-session"].each do |k, v|
        if not v
            params[:"admin-session"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["admin-session"].each do |k, v|
        if v != params[:"admin-session"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating admin-session') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin-session"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting admin-session') do
            client.delete(url)
        end
    end
end