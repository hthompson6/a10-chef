resource_name :a10_ssh_login_grace_time

property :a10_name, String, name_property: true
property :grace_time, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/ssh-login-grace-time"
    grace_time = new_resource.grace_time
    uuid = new_resource.uuid

    params = { "ssh-login-grace-time": {"grace-time": grace_time,
        "uuid": uuid,} }

    params[:"ssh-login-grace-time"].each do |k, v|
        if not v 
            params[:"ssh-login-grace-time"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssh-login-grace-time') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ssh-login-grace-time"
    grace_time = new_resource.grace_time
    uuid = new_resource.uuid

    params = { "ssh-login-grace-time": {"grace-time": grace_time,
        "uuid": uuid,} }

    params[:"ssh-login-grace-time"].each do |k, v|
        if not v
            params[:"ssh-login-grace-time"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssh-login-grace-time"].each do |k, v|
        if v != params[:"ssh-login-grace-time"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssh-login-grace-time') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ssh-login-grace-time"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssh-login-grace-time') do
            client.delete(url)
        end
    end
end