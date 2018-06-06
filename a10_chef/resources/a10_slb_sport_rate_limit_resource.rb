resource_name :a10_slb_sport_rate_limit

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/sport-rate-limit"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "sport-rate-limit": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"sport-rate-limit"].each do |k, v|
        if not v 
            params[:"sport-rate-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sport-rate-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/sport-rate-limit"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "sport-rate-limit": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"sport-rate-limit"].each do |k, v|
        if not v
            params[:"sport-rate-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sport-rate-limit"].each do |k, v|
        if v != params[:"sport-rate-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sport-rate-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/sport-rate-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sport-rate-limit') do
            client.delete(url)
        end
    end
end