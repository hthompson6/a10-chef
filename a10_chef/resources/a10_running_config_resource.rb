resource_name :a10_running_config

property :a10_name, String, name_property: true
property :aflex, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/running-config"
    aflex = new_resource.aflex
    uuid = new_resource.uuid

    params = { "running-config": {"aflex": aflex,
        "uuid": uuid,} }

    params[:"running-config"].each do |k, v|
        if not v 
            params[:"running-config"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating running-config') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/running-config"
    aflex = new_resource.aflex
    uuid = new_resource.uuid

    params = { "running-config": {"aflex": aflex,
        "uuid": uuid,} }

    params[:"running-config"].each do |k, v|
        if not v
            params[:"running-config"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["running-config"].each do |k, v|
        if v != params[:"running-config"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating running-config') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/running-config"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting running-config') do
            client.delete(url)
        end
    end
end