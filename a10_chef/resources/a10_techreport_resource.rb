resource_name :a10_techreport

property :a10_name, String, name_property: true
property :disable, [true, false]
property :priority_partition_list, Array
property :interval, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/techreport"
    disable = new_resource.disable
    priority_partition_list = new_resource.priority_partition_list
    interval = new_resource.interval
    uuid = new_resource.uuid

    params = { "techreport": {"disable": disable,
        "priority-partition-list": priority_partition_list,
        "interval": interval,
        "uuid": uuid,} }

    params[:"techreport"].each do |k, v|
        if not v 
            params[:"techreport"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating techreport') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/techreport"
    disable = new_resource.disable
    priority_partition_list = new_resource.priority_partition_list
    interval = new_resource.interval
    uuid = new_resource.uuid

    params = { "techreport": {"disable": disable,
        "priority-partition-list": priority_partition_list,
        "interval": interval,
        "uuid": uuid,} }

    params[:"techreport"].each do |k, v|
        if not v
            params[:"techreport"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["techreport"].each do |k, v|
        if v != params[:"techreport"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating techreport') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/techreport"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting techreport') do
            client.delete(url)
        end
    end
end