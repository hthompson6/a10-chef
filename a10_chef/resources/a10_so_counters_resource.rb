resource_name :a10_so_counters

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/so-counters"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "so-counters": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"so-counters"].each do |k, v|
        if not v 
            params[:"so-counters"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating so-counters') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/so-counters"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "so-counters": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"so-counters"].each do |k, v|
        if not v
            params[:"so-counters"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["so-counters"].each do |k, v|
        if v != params[:"so-counters"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating so-counters') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/so-counters"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting so-counters') do
            client.delete(url)
        end
    end
end