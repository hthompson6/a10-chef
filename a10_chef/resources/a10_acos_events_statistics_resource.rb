resource_name :a10_acos_events_statistics

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/"
    get_url = "/axapi/v3/acos-events/statistics"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "statistics": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"statistics"].each do |k, v|
        if not v 
            params[:"statistics"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating statistics') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/statistics"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "statistics": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"statistics"].each do |k, v|
        if not v
            params[:"statistics"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["statistics"].each do |k, v|
        if v != params[:"statistics"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating statistics') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/statistics"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting statistics') do
            client.delete(url)
        end
    end
end