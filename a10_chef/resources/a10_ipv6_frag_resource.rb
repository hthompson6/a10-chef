resource_name :a10_ipv6_frag

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String
property :frag_timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/"
    get_url = "/axapi/v3/ipv6/frag"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    frag_timeout = new_resource.frag_timeout

    params = { "frag": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "frag-timeout": frag_timeout,} }

    params[:"frag"].each do |k, v|
        if not v 
            params[:"frag"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating frag') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/frag"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    frag_timeout = new_resource.frag_timeout

    params = { "frag": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "frag-timeout": frag_timeout,} }

    params[:"frag"].each do |k, v|
        if not v
            params[:"frag"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["frag"].each do |k, v|
        if v != params[:"frag"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating frag') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/frag"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting frag') do
            client.delete(url)
        end
    end
end