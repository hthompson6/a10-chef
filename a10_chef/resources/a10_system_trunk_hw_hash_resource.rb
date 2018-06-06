resource_name :a10_system_trunk_hw_hash

property :a10_name, String, name_property: true
property :mode, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/trunk-hw-hash"
    mode = new_resource.mode
    uuid = new_resource.uuid

    params = { "trunk-hw-hash": {"mode": mode,
        "uuid": uuid,} }

    params[:"trunk-hw-hash"].each do |k, v|
        if not v 
            params[:"trunk-hw-hash"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trunk-hw-hash') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/trunk-hw-hash"
    mode = new_resource.mode
    uuid = new_resource.uuid

    params = { "trunk-hw-hash": {"mode": mode,
        "uuid": uuid,} }

    params[:"trunk-hw-hash"].each do |k, v|
        if not v
            params[:"trunk-hw-hash"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trunk-hw-hash"].each do |k, v|
        if v != params[:"trunk-hw-hash"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trunk-hw-hash') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/trunk-hw-hash"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trunk-hw-hash') do
            client.delete(url)
        end
    end
end