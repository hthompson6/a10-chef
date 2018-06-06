resource_name :a10_cgnv6_lsn_tcp_mss_clamp

property :a10_name, String, name_property: true
property :mss_subtract, Integer
property :mss_value, Integer
property :mss_clamp_type, ['fixed','subtract','none']
property :uuid, String
property :min, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/tcp/"
    get_url = "/axapi/v3/cgnv6/lsn/tcp/mss-clamp"
    mss_subtract = new_resource.mss_subtract
    mss_value = new_resource.mss_value
    mss_clamp_type = new_resource.mss_clamp_type
    uuid = new_resource.uuid
    min = new_resource.min

    params = { "mss-clamp": {"mss-subtract": mss_subtract,
        "mss-value": mss_value,
        "mss-clamp-type": mss_clamp_type,
        "uuid": uuid,
        "min": min,} }

    params[:"mss-clamp"].each do |k, v|
        if not v 
            params[:"mss-clamp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mss-clamp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/tcp/mss-clamp"
    mss_subtract = new_resource.mss_subtract
    mss_value = new_resource.mss_value
    mss_clamp_type = new_resource.mss_clamp_type
    uuid = new_resource.uuid
    min = new_resource.min

    params = { "mss-clamp": {"mss-subtract": mss_subtract,
        "mss-value": mss_value,
        "mss-clamp-type": mss_clamp_type,
        "uuid": uuid,
        "min": min,} }

    params[:"mss-clamp"].each do |k, v|
        if not v
            params[:"mss-clamp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mss-clamp"].each do |k, v|
        if v != params[:"mss-clamp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mss-clamp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/tcp/mss-clamp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mss-clamp') do
            client.delete(url)
        end
    end
end