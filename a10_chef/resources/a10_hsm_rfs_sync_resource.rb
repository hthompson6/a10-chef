resource_name :a10_hsm_rfs_sync

property :a10_name, String, name_property: true


property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/hsm/"
    get_url = "/axapi/v3/hsm/rfs-sync"
    

    params = { "rfs-sync": {} }

    params[:"rfs-sync"].each do |k, v|
        if not v 
            params[:"rfs-sync"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rfs-sync') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hsm/rfs-sync"
    

    params = { "rfs-sync": {} }

    params[:"rfs-sync"].each do |k, v|
        if not v
            params[:"rfs-sync"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rfs-sync"].each do |k, v|
        if v != params[:"rfs-sync"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rfs-sync') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hsm/rfs-sync"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rfs-sync') do
            client.delete(url)
        end
    end
end