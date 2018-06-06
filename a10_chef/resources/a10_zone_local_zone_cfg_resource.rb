resource_name :a10_zone_local_zone_cfg

property :a10_name, String, name_property: true
property :local_type, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/zone/%<name>s/"
    get_url = "/axapi/v3/zone/%<name>s/local-zone-cfg"
    local_type = new_resource.local_type
    uuid = new_resource.uuid

    params = { "local-zone-cfg": {"local-type": local_type,
        "uuid": uuid,} }

    params[:"local-zone-cfg"].each do |k, v|
        if not v 
            params[:"local-zone-cfg"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating local-zone-cfg') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/local-zone-cfg"
    local_type = new_resource.local_type
    uuid = new_resource.uuid

    params = { "local-zone-cfg": {"local-type": local_type,
        "uuid": uuid,} }

    params[:"local-zone-cfg"].each do |k, v|
        if not v
            params[:"local-zone-cfg"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["local-zone-cfg"].each do |k, v|
        if v != params[:"local-zone-cfg"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating local-zone-cfg') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/local-zone-cfg"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting local-zone-cfg') do
            client.delete(url)
        end
    end
end