resource_name :a10_logging_buffered

property :a10_name, String, name_property: true
property :buffersize, Integer
property :partition_buffersize, Integer
property :levelname, ['disable','emergency','alert','critical','error','warning','notification','information','debugging']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/buffered"
    buffersize = new_resource.buffersize
    partition_buffersize = new_resource.partition_buffersize
    levelname = new_resource.levelname
    uuid = new_resource.uuid

    params = { "buffered": {"buffersize": buffersize,
        "partition-buffersize": partition_buffersize,
        "levelname": levelname,
        "uuid": uuid,} }

    params[:"buffered"].each do |k, v|
        if not v 
            params[:"buffered"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating buffered') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/buffered"
    buffersize = new_resource.buffersize
    partition_buffersize = new_resource.partition_buffersize
    levelname = new_resource.levelname
    uuid = new_resource.uuid

    params = { "buffered": {"buffersize": buffersize,
        "partition-buffersize": partition_buffersize,
        "levelname": levelname,
        "uuid": uuid,} }

    params[:"buffered"].each do |k, v|
        if not v
            params[:"buffered"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["buffered"].each do |k, v|
        if v != params[:"buffered"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating buffered') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/buffered"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting buffered') do
            client.delete(url)
        end
    end
end