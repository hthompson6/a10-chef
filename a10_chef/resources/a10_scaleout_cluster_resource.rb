resource_name :a10_scaleout_cluster

property :a10_name, String, name_property: true
property :local_device, Hash
property :cluster_id, Integer,required: true
property :uuid, String
property :cluster_devices, Hash
property :follow_vcs, [true, false]
property :device_groups, Hash
property :service_config, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s"
    local_device = new_resource.local_device
    cluster_id = new_resource.cluster_id
    uuid = new_resource.uuid
    cluster_devices = new_resource.cluster_devices
    follow_vcs = new_resource.follow_vcs
    device_groups = new_resource.device_groups
    service_config = new_resource.service_config

    params = { "cluster": {"local-device": local_device,
        "cluster-id": cluster_id,
        "uuid": uuid,
        "cluster-devices": cluster_devices,
        "follow-vcs": follow_vcs,
        "device-groups": device_groups,
        "service-config": service_config,} }

    params[:"cluster"].each do |k, v|
        if not v 
            params[:"cluster"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cluster') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s"
    local_device = new_resource.local_device
    cluster_id = new_resource.cluster_id
    uuid = new_resource.uuid
    cluster_devices = new_resource.cluster_devices
    follow_vcs = new_resource.follow_vcs
    device_groups = new_resource.device_groups
    service_config = new_resource.service_config

    params = { "cluster": {"local-device": local_device,
        "cluster-id": cluster_id,
        "uuid": uuid,
        "cluster-devices": cluster_devices,
        "follow-vcs": follow_vcs,
        "device-groups": device_groups,
        "service-config": service_config,} }

    params[:"cluster"].each do |k, v|
        if not v
            params[:"cluster"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cluster"].each do |k, v|
        if v != params[:"cluster"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cluster') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cluster') do
            client.delete(url)
        end
    end
end