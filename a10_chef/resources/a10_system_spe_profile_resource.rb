resource_name :a10_system_spe_profile

property :a10_name, String, name_property: true
property :a10_action, ['ipv4-only','ipv6-only','ipv4-ipv6']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/spe-profile"
    a10_name = new_resource.a10_name

    params = { "spe-profile": {"action": a10_action,} }

    params[:"spe-profile"].each do |k, v|
        if not v 
            params[:"spe-profile"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating spe-profile') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/spe-profile"
    a10_name = new_resource.a10_name

    params = { "spe-profile": {"action": a10_action,} }

    params[:"spe-profile"].each do |k, v|
        if not v
            params[:"spe-profile"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["spe-profile"].each do |k, v|
        if v != params[:"spe-profile"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating spe-profile') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/spe-profile"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting spe-profile') do
            client.delete(url)
        end
    end
end