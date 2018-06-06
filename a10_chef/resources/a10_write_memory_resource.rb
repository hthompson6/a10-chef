resource_name :a10_write_memory

property :a10_name, String, name_property: true
property :profile, String
property :specified_partition, String
property :destination, ['primary','secondary','local']
property :cf, [true, false]
property :partition, ['all','shared','specified']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/write/"
    get_url = "/axapi/v3/write/memory"
    profile = new_resource.profile
    specified_partition = new_resource.specified_partition
    destination = new_resource.destination
    cf = new_resource.cf
    partition = new_resource.partition

    params = { "memory": {"profile": profile,
        "specified-partition": specified_partition,
        "destination": destination,
        "cf": cf,
        "partition": partition,} }

    params[:"memory"].each do |k, v|
        if not v 
            params[:"memory"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating memory') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/write/memory"
    profile = new_resource.profile
    specified_partition = new_resource.specified_partition
    destination = new_resource.destination
    cf = new_resource.cf
    partition = new_resource.partition

    params = { "memory": {"profile": profile,
        "specified-partition": specified_partition,
        "destination": destination,
        "cf": cf,
        "partition": partition,} }

    params[:"memory"].each do |k, v|
        if not v
            params[:"memory"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["memory"].each do |k, v|
        if v != params[:"memory"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating memory') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/write/memory"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting memory') do
            client.delete(url)
        end
    end
end