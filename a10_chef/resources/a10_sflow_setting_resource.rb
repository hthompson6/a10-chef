resource_name :a10_sflow_setting

property :a10_name, String, name_property: true
property :source_ip_use_mgmt, [true, false]
property :uuid, String
property :counter_polling_interval, Integer
property :packet_sampling_rate, Integer
property :local_collection, [true, false]
property :max_header, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sflow/"
    get_url = "/axapi/v3/sflow/setting"
    source_ip_use_mgmt = new_resource.source_ip_use_mgmt
    uuid = new_resource.uuid
    counter_polling_interval = new_resource.counter_polling_interval
    packet_sampling_rate = new_resource.packet_sampling_rate
    local_collection = new_resource.local_collection
    max_header = new_resource.max_header

    params = { "setting": {"source-ip-use-mgmt": source_ip_use_mgmt,
        "uuid": uuid,
        "counter-polling-interval": counter_polling_interval,
        "packet-sampling-rate": packet_sampling_rate,
        "local-collection": local_collection,
        "max-header": max_header,} }

    params[:"setting"].each do |k, v|
        if not v 
            params[:"setting"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating setting') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sflow/setting"
    source_ip_use_mgmt = new_resource.source_ip_use_mgmt
    uuid = new_resource.uuid
    counter_polling_interval = new_resource.counter_polling_interval
    packet_sampling_rate = new_resource.packet_sampling_rate
    local_collection = new_resource.local_collection
    max_header = new_resource.max_header

    params = { "setting": {"source-ip-use-mgmt": source_ip_use_mgmt,
        "uuid": uuid,
        "counter-polling-interval": counter_polling_interval,
        "packet-sampling-rate": packet_sampling_rate,
        "local-collection": local_collection,
        "max-header": max_header,} }

    params[:"setting"].each do |k, v|
        if not v
            params[:"setting"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["setting"].each do |k, v|
        if v != params[:"setting"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating setting') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sflow/setting"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting setting') do
            client.delete(url)
        end
    end
end