resource_name :a10_vcs_vMaster_maintenance

property :a10_name, String, name_property: true
property :vMaster_maintenance, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/"
    get_url = "/axapi/v3/vcs/vMaster-maintenance"
    vMaster_maintenance = new_resource.vMaster_maintenance

    params = { "vMaster-maintenance": {"vMaster-maintenance": vMaster_maintenance,} }

    params[:"vMaster-maintenance"].each do |k, v|
        if not v 
            params[:"vMaster-maintenance"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vMaster-maintenance') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vMaster-maintenance"
    vMaster_maintenance = new_resource.vMaster_maintenance

    params = { "vMaster-maintenance": {"vMaster-maintenance": vMaster_maintenance,} }

    params[:"vMaster-maintenance"].each do |k, v|
        if not v
            params[:"vMaster-maintenance"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vMaster-maintenance"].each do |k, v|
        if v != params[:"vMaster-maintenance"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vMaster-maintenance') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vMaster-maintenance"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vMaster-maintenance') do
            client.delete(url)
        end
    end
end