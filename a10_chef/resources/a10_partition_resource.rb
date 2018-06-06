resource_name :a10_partition

property :a10_name, String, name_property: true
property :uuid, String
property :user_tag, String
property :partition_name, String,required: true
property :shared_vlan, Hash
property :template, Hash
property :application_type, ['adc','cgnv6']
property :id, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/partition/"
    get_url = "/axapi/v3/partition/%<partition-name>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    partition_name = new_resource.partition_name
    shared_vlan = new_resource.shared_vlan
    template = new_resource.template
    application_type = new_resource.application_type
    id = new_resource.id

    params = { "partition": {"uuid": uuid,
        "user-tag": user_tag,
        "partition-name": partition_name,
        "shared-vlan": shared_vlan,
        "template": template,
        "application-type": application_type,
        "id": id,} }

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
    url = "/axapi/v3/partition/%<partition-name>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    partition_name = new_resource.partition_name
    shared_vlan = new_resource.shared_vlan
    template = new_resource.template
    application_type = new_resource.application_type
    id = new_resource.id

    params = { "partition": {"uuid": uuid,
        "user-tag": user_tag,
        "partition-name": partition_name,
        "shared-vlan": shared_vlan,
        "template": template,
        "application-type": application_type,
        "id": id,} }

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
    url = "/axapi/v3/partition/%<partition-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting partition') do
            client.delete(url)
        end
    end
end