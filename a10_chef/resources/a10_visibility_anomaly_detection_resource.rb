resource_name :a10_visibility_anomaly_detection

property :a10_name, String, name_property: true
property :restart_learning_on_anomaly, [true, false]
property :sensitivity, ['high','low']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/"
    get_url = "/axapi/v3/visibility/anomaly-detection"
    restart_learning_on_anomaly = new_resource.restart_learning_on_anomaly
    sensitivity = new_resource.sensitivity
    uuid = new_resource.uuid

    params = { "anomaly-detection": {"restart-learning-on-anomaly": restart_learning_on_anomaly,
        "sensitivity": sensitivity,
        "uuid": uuid,} }

    params[:"anomaly-detection"].each do |k, v|
        if not v 
            params[:"anomaly-detection"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating anomaly-detection') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/anomaly-detection"
    restart_learning_on_anomaly = new_resource.restart_learning_on_anomaly
    sensitivity = new_resource.sensitivity
    uuid = new_resource.uuid

    params = { "anomaly-detection": {"restart-learning-on-anomaly": restart_learning_on_anomaly,
        "sensitivity": sensitivity,
        "uuid": uuid,} }

    params[:"anomaly-detection"].each do |k, v|
        if not v
            params[:"anomaly-detection"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["anomaly-detection"].each do |k, v|
        if v != params[:"anomaly-detection"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating anomaly-detection') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/anomaly-detection"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting anomaly-detection') do
            client.delete(url)
        end
    end
end