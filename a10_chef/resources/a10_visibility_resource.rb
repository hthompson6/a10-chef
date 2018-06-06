resource_name :a10_visibility

property :a10_name, String, name_property: true
property :anomaly_detection, Hash
property :uuid, String
property :reporting, Hash
property :monitored_entity, Hash
property :monitor_list, Array
property :granularity, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/visibility"
    anomaly_detection = new_resource.anomaly_detection
    uuid = new_resource.uuid
    reporting = new_resource.reporting
    monitored_entity = new_resource.monitored_entity
    monitor_list = new_resource.monitor_list
    granularity = new_resource.granularity

    params = { "visibility": {"anomaly-detection": anomaly_detection,
        "uuid": uuid,
        "reporting": reporting,
        "monitored-entity": monitored_entity,
        "monitor-list": monitor_list,
        "granularity": granularity,} }

    params[:"visibility"].each do |k, v|
        if not v 
            params[:"visibility"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating visibility') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility"
    anomaly_detection = new_resource.anomaly_detection
    uuid = new_resource.uuid
    reporting = new_resource.reporting
    monitored_entity = new_resource.monitored_entity
    monitor_list = new_resource.monitor_list
    granularity = new_resource.granularity

    params = { "visibility": {"anomaly-detection": anomaly_detection,
        "uuid": uuid,
        "reporting": reporting,
        "monitored-entity": monitored_entity,
        "monitor-list": monitor_list,
        "granularity": granularity,} }

    params[:"visibility"].each do |k, v|
        if not v
            params[:"visibility"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["visibility"].each do |k, v|
        if v != params[:"visibility"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating visibility') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting visibility') do
            client.delete(url)
        end
    end
end