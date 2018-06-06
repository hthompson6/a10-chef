resource_name :a10_system_jumbo_global

property :a10_name, String, name_property: true
property :enable_jumbo, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-jumbo-global"
    enable_jumbo = new_resource.enable_jumbo
    uuid = new_resource.uuid

    params = { "system-jumbo-global": {"enable-jumbo": enable_jumbo,
        "uuid": uuid,} }

    params[:"system-jumbo-global"].each do |k, v|
        if not v 
            params[:"system-jumbo-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-jumbo-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-jumbo-global"
    enable_jumbo = new_resource.enable_jumbo
    uuid = new_resource.uuid

    params = { "system-jumbo-global": {"enable-jumbo": enable_jumbo,
        "uuid": uuid,} }

    params[:"system-jumbo-global"].each do |k, v|
        if not v
            params[:"system-jumbo-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-jumbo-global"].each do |k, v|
        if v != params[:"system-jumbo-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-jumbo-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-jumbo-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-jumbo-global') do
            client.delete(url)
        end
    end
end