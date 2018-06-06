resource_name :a10_active_service_partition

property :a10_name, String, name_property: true
property :curr_part_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/active-service-partition"
    curr_part_name = new_resource.curr_part_name

    params = { "active-service-partition": {"curr_part_name": curr_part_name,} }

    params[:"active-service-partition"].each do |k, v|
        if not v 
            params[:"active-service-partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating active-service-partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/active-service-partition"
    curr_part_name = new_resource.curr_part_name

    params = { "active-service-partition": {"curr_part_name": curr_part_name,} }

    params[:"active-service-partition"].each do |k, v|
        if not v
            params[:"active-service-partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["active-service-partition"].each do |k, v|
        if v != params[:"active-service-partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating active-service-partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/active-service-partition"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting active-service-partition') do
            client.delete(url)
        end
    end
end