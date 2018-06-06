resource_name :a10_service_partition

property :a10_name, String, name_property: true
property :partition_name, String,required: true
property :id, Integer
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/service-partition/"
    get_url = "/axapi/v3/service-partition/%<partition-name>s"
    partition_name = new_resource.partition_name
    id = new_resource.id
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "service-partition": {"partition-name": partition_name,
        "id": id,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"service-partition"].each do |k, v|
        if not v 
            params[:"service-partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/service-partition/%<partition-name>s"
    partition_name = new_resource.partition_name
    id = new_resource.id
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "service-partition": {"partition-name": partition_name,
        "id": id,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"service-partition"].each do |k, v|
        if not v
            params[:"service-partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-partition"].each do |k, v|
        if v != params[:"service-partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/service-partition/%<partition-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-partition') do
            client.delete(url)
        end
    end
end