resource_name :a10_rate_limit

property :a10_name, String, name_property: true
property :maxPktNum, Integer
property :rl_type, ['ctrl']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/rate-limit"
    maxPktNum = new_resource.maxPktNum
    rl_type = new_resource.rl_type
    uuid = new_resource.uuid

    params = { "rate-limit": {"maxPktNum": maxPktNum,
        "rl-type": rl_type,
        "uuid": uuid,} }

    params[:"rate-limit"].each do |k, v|
        if not v 
            params[:"rate-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rate-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rate-limit"
    maxPktNum = new_resource.maxPktNum
    rl_type = new_resource.rl_type
    uuid = new_resource.uuid

    params = { "rate-limit": {"maxPktNum": maxPktNum,
        "rl-type": rl_type,
        "uuid": uuid,} }

    params[:"rate-limit"].each do |k, v|
        if not v
            params[:"rate-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rate-limit"].each do |k, v|
        if v != params[:"rate-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rate-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rate-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rate-limit') do
            client.delete(url)
        end
    end
end