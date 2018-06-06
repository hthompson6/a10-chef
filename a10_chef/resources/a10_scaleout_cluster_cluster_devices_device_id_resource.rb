resource_name :a10_scaleout_cluster_cluster_devices_device_id

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']
property :device_id, Integer,required: true
property :uuid, String
property :user_tag, String
property :ip, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices/device-id/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices/device-id/%<device-id>s"
    a10_name = new_resource.a10_name
    device_id = new_resource.device_id
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ip = new_resource.ip

    params = { "device-id": {"action": a10_action,
        "device-id": device_id,
        "uuid": uuid,
        "user-tag": user_tag,
        "ip": ip,} }

    params[:"device-id"].each do |k, v|
        if not v 
            params[:"device-id"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating device-id') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices/device-id/%<device-id>s"
    a10_name = new_resource.a10_name
    device_id = new_resource.device_id
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ip = new_resource.ip

    params = { "device-id": {"action": a10_action,
        "device-id": device_id,
        "uuid": uuid,
        "user-tag": user_tag,
        "ip": ip,} }

    params[:"device-id"].each do |k, v|
        if not v
            params[:"device-id"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["device-id"].each do |k, v|
        if v != params[:"device-id"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating device-id') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices/device-id/%<device-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting device-id') do
            client.delete(url)
        end
    end
end