resource_name :a10_debug_rt

property :a10_name, String, name_property: true
property :all, [true, false]
property :command, [true, false]
property :check, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/rt"
    all = new_resource.all
    command = new_resource.command
    check = new_resource.check
    uuid = new_resource.uuid

    params = { "rt": {"all": all,
        "command": command,
        "check": check,
        "uuid": uuid,} }

    params[:"rt"].each do |k, v|
        if not v 
            params[:"rt"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rt') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/rt"
    all = new_resource.all
    command = new_resource.command
    check = new_resource.check
    uuid = new_resource.uuid

    params = { "rt": {"all": all,
        "command": command,
        "check": check,
        "uuid": uuid,} }

    params[:"rt"].each do |k, v|
        if not v
            params[:"rt"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rt"].each do |k, v|
        if v != params[:"rt"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rt') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/rt"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rt') do
            client.delete(url)
        end
    end
end