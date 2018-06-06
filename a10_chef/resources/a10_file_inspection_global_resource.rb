resource_name :a10_file_inspection_global

property :a10_name, String, name_property: true
property :max_file_size, Integer
property :max_buffer_size, Integer
property :local_logging, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file-inspection/"
    get_url = "/axapi/v3/file-inspection/global"
    max_file_size = new_resource.max_file_size
    max_buffer_size = new_resource.max_buffer_size
    local_logging = new_resource.local_logging
    uuid = new_resource.uuid

    params = { "global": {"max-file-size": max_file_size,
        "max-buffer-size": max_buffer_size,
        "local-logging": local_logging,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/global"
    max_file_size = new_resource.max_file_size
    max_buffer_size = new_resource.max_buffer_size
    local_logging = new_resource.local_logging
    uuid = new_resource.uuid

    params = { "global": {"max-file-size": max_file_size,
        "max-buffer-size": max_buffer_size,
        "local-logging": local_logging,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end