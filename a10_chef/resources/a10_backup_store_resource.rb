resource_name :a10_backup_store

property :a10_name, String, name_property: true
property :delete_cfg, Hash
property :creat_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/backup/"
    get_url = "/axapi/v3/backup/store"
    delete_cfg = new_resource.delete_cfg
    creat_cfg = new_resource.creat_cfg

    params = { "store": {"delete-cfg": delete_cfg,
        "creat-cfg": creat_cfg,} }

    params[:"store"].each do |k, v|
        if not v 
            params[:"store"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating store') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/store"
    delete_cfg = new_resource.delete_cfg
    creat_cfg = new_resource.creat_cfg

    params = { "store": {"delete-cfg": delete_cfg,
        "creat-cfg": creat_cfg,} }

    params[:"store"].each do |k, v|
        if not v
            params[:"store"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["store"].each do |k, v|
        if v != params[:"store"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating store') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup/store"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting store') do
            client.delete(url)
        end
    end
end