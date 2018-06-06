resource_name :a10_logging_host_partition

property :a10_name, String, name_property: true
property :partition_name, String
property :shared, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/host/"
    get_url = "/axapi/v3/logging/host/partition"
    partition_name = new_resource.partition_name
    shared = new_resource.shared
    uuid = new_resource.uuid

    params = { "partition": {"partition-name": partition_name,
        "shared": shared,
        "uuid": uuid,} }

    params[:"partition"].each do |k, v|
        if not v 
            params[:"partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/host/partition"
    partition_name = new_resource.partition_name
    shared = new_resource.shared
    uuid = new_resource.uuid

    params = { "partition": {"partition-name": partition_name,
        "shared": shared,
        "uuid": uuid,} }

    params[:"partition"].each do |k, v|
        if not v
            params[:"partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["partition"].each do |k, v|
        if v != params[:"partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/host/partition"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting partition') do
            client.delete(url)
        end
    end
end