resource_name :a10_link_startup_config

property :a10_name, String, name_property: true
property :default, [true, false]
property :file_name, String
property :primary, [true, false]
property :all_partitions, [true, false]
property :secondary, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/link/"
    get_url = "/axapi/v3/link/startup-config"
    default = new_resource.default
    file_name = new_resource.file_name
    primary = new_resource.primary
    all_partitions = new_resource.all_partitions
    secondary = new_resource.secondary

    params = { "startup-config": {"default": default,
        "file-name": file_name,
        "primary": primary,
        "all-partitions": all_partitions,
        "secondary": secondary,} }

    params[:"startup-config"].each do |k, v|
        if not v 
            params[:"startup-config"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating startup-config') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/link/startup-config"
    default = new_resource.default
    file_name = new_resource.file_name
    primary = new_resource.primary
    all_partitions = new_resource.all_partitions
    secondary = new_resource.secondary

    params = { "startup-config": {"default": default,
        "file-name": file_name,
        "primary": primary,
        "all-partitions": all_partitions,
        "secondary": secondary,} }

    params[:"startup-config"].each do |k, v|
        if not v
            params[:"startup-config"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["startup-config"].each do |k, v|
        if v != params[:"startup-config"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating startup-config') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/link/startup-config"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting startup-config') do
            client.delete(url)
        end
    end
end