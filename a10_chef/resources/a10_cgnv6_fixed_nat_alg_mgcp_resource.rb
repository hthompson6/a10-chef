resource_name :a10_cgnv6_fixed_nat_alg_mgcp

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/fixed-nat/alg/"
    get_url = "/axapi/v3/cgnv6/fixed-nat/alg/mgcp"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "mgcp": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"mgcp"].each do |k, v|
        if not v 
            params[:"mgcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mgcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/alg/mgcp"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "mgcp": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"mgcp"].each do |k, v|
        if not v
            params[:"mgcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mgcp"].each do |k, v|
        if v != params[:"mgcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mgcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/alg/mgcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mgcp') do
            client.delete(url)
        end
    end
end