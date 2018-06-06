resource_name :a10_cgnv6_one_to_one_global

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :mapping_timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/one-to-one/"
    get_url = "/axapi/v3/cgnv6/one-to-one/global"
    sampling_enable = new_resource.sampling_enable
    mapping_timeout = new_resource.mapping_timeout
    uuid = new_resource.uuid

    params = { "global": {"sampling-enable": sampling_enable,
        "mapping-timeout": mapping_timeout,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/one-to-one/global"
    sampling_enable = new_resource.sampling_enable
    mapping_timeout = new_resource.mapping_timeout
    uuid = new_resource.uuid

    params = { "global": {"sampling-enable": sampling_enable,
        "mapping-timeout": mapping_timeout,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/one-to-one/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end