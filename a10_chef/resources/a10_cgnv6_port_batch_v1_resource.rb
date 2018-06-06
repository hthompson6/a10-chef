resource_name :a10_cgnv6_port_batch_v1

property :a10_name, String, name_property: true
property :enable_port_batch_v1, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/port-batch-v1"
    enable_port_batch_v1 = new_resource.enable_port_batch_v1
    uuid = new_resource.uuid

    params = { "port-batch-v1": {"enable-port-batch-v1": enable_port_batch_v1,
        "uuid": uuid,} }

    params[:"port-batch-v1"].each do |k, v|
        if not v 
            params[:"port-batch-v1"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port-batch-v1') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/port-batch-v1"
    enable_port_batch_v1 = new_resource.enable_port_batch_v1
    uuid = new_resource.uuid

    params = { "port-batch-v1": {"enable-port-batch-v1": enable_port_batch_v1,
        "uuid": uuid,} }

    params[:"port-batch-v1"].each do |k, v|
        if not v
            params[:"port-batch-v1"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port-batch-v1"].each do |k, v|
        if v != params[:"port-batch-v1"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port-batch-v1') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/port-batch-v1"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port-batch-v1') do
            client.delete(url)
        end
    end
end