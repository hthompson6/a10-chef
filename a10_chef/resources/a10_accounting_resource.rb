resource_name :a10_accounting

property :a10_name, String, name_property: true
property :commands, Integer
property :uuid, String
property :nexec, Hash
property :stop_only, [true, false]
property :tacplus, [true, false]
property :debug, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/accounting"
    commands = new_resource.commands
    uuid = new_resource.uuid
    nexec = new_resource.nexec
    stop_only = new_resource.stop_only
    tacplus = new_resource.tacplus
    debug = new_resource.debug

    params = { "accounting": {"commands": commands,
        "uuid": uuid,
        "exec": nexec,
        "stop-only": stop_only,
        "tacplus": tacplus,
        "debug": debug,} }

    params[:"accounting"].each do |k, v|
        if not v 
            params[:"accounting"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating accounting') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/accounting"
    commands = new_resource.commands
    uuid = new_resource.uuid
    nexec = new_resource.nexec
    stop_only = new_resource.stop_only
    tacplus = new_resource.tacplus
    debug = new_resource.debug

    params = { "accounting": {"commands": commands,
        "uuid": uuid,
        "exec": nexec,
        "stop-only": stop_only,
        "tacplus": tacplus,
        "debug": debug,} }

    params[:"accounting"].each do |k, v|
        if not v
            params[:"accounting"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["accounting"].each do |k, v|
        if v != params[:"accounting"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating accounting') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/accounting"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting accounting') do
            client.delete(url)
        end
    end
end