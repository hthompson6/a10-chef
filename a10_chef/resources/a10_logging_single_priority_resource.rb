resource_name :a10_logging_single_priority

property :a10_name, String, name_property: true
property :uuid, String
property :levelname, ['emergency','alert','critical','error','warning','notification','information','debugging'],required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/single-priority/"
    get_url = "/axapi/v3/logging/single-priority/%<levelname>s"
    uuid = new_resource.uuid
    levelname = new_resource.levelname

    params = { "single-priority": {"uuid": uuid,
        "levelname": levelname,} }

    params[:"single-priority"].each do |k, v|
        if not v 
            params[:"single-priority"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating single-priority') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/single-priority/%<levelname>s"
    uuid = new_resource.uuid
    levelname = new_resource.levelname

    params = { "single-priority": {"uuid": uuid,
        "levelname": levelname,} }

    params[:"single-priority"].each do |k, v|
        if not v
            params[:"single-priority"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["single-priority"].each do |k, v|
        if v != params[:"single-priority"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating single-priority') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/single-priority/%<levelname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting single-priority') do
            client.delete(url)
        end
    end
end