resource_name :a10_techreport_priority_partition

property :a10_name, String, name_property: true
property :part_name, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/techreport/priority-partition/"
    get_url = "/axapi/v3/techreport/priority-partition/%<part-name>s"
    part_name = new_resource.part_name
    uuid = new_resource.uuid

    params = { "priority-partition": {"part-name": part_name,
        "uuid": uuid,} }

    params[:"priority-partition"].each do |k, v|
        if not v 
            params[:"priority-partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating priority-partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/techreport/priority-partition/%<part-name>s"
    part_name = new_resource.part_name
    uuid = new_resource.uuid

    params = { "priority-partition": {"part-name": part_name,
        "uuid": uuid,} }

    params[:"priority-partition"].each do |k, v|
        if not v
            params[:"priority-partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["priority-partition"].each do |k, v|
        if v != params[:"priority-partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating priority-partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/techreport/priority-partition/%<part-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting priority-partition') do
            client.delete(url)
        end
    end
end