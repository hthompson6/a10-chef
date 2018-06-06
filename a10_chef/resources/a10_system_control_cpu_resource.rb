resource_name :a10_system_control_cpu

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/control-cpu"
    uuid = new_resource.uuid

    params = { "control-cpu": {"uuid": uuid,} }

    params[:"control-cpu"].each do |k, v|
        if not v 
            params[:"control-cpu"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating control-cpu') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/control-cpu"
    uuid = new_resource.uuid

    params = { "control-cpu": {"uuid": uuid,} }

    params[:"control-cpu"].each do |k, v|
        if not v
            params[:"control-cpu"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["control-cpu"].each do |k, v|
        if v != params[:"control-cpu"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating control-cpu') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/control-cpu"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting control-cpu') do
            client.delete(url)
        end
    end
end