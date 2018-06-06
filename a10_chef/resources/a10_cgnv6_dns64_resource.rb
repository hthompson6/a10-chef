resource_name :a10_cgnv6_dns64

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/dns64"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "dns64": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"dns64"].each do |k, v|
        if not v 
            params[:"dns64"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns64') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "dns64": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"dns64"].each do |k, v|
        if not v
            params[:"dns64"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns64"].each do |k, v|
        if v != params[:"dns64"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns64') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns64') do
            client.delete(url)
        end
    end
end