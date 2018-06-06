resource_name :a10_cgnv6_logging_nat_resource_exhausted

property :a10_name, String, name_property: true
property :uuid, String
property :level, ['warning','critical','notice']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/logging/"
    get_url = "/axapi/v3/cgnv6/logging/nat-resource-exhausted"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "nat-resource-exhausted": {"uuid": uuid,
        "level": level,} }

    params[:"nat-resource-exhausted"].each do |k, v|
        if not v 
            params[:"nat-resource-exhausted"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nat-resource-exhausted') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/logging/nat-resource-exhausted"
    uuid = new_resource.uuid
    level = new_resource.level

    params = { "nat-resource-exhausted": {"uuid": uuid,
        "level": level,} }

    params[:"nat-resource-exhausted"].each do |k, v|
        if not v
            params[:"nat-resource-exhausted"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nat-resource-exhausted"].each do |k, v|
        if v != params[:"nat-resource-exhausted"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nat-resource-exhausted') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/logging/nat-resource-exhausted"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nat-resource-exhausted') do
            client.delete(url)
        end
    end
end