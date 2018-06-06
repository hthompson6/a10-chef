resource_name :a10_scaleout_cluster_cluster_devices

property :a10_name, String, name_property: true
property :device_id_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices"
    device_id_list = new_resource.device_id_list
    uuid = new_resource.uuid

    params = { "cluster-devices": {"device-id-list": device_id_list,
        "uuid": uuid,} }

    params[:"cluster-devices"].each do |k, v|
        if not v 
            params[:"cluster-devices"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cluster-devices') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices"
    device_id_list = new_resource.device_id_list
    uuid = new_resource.uuid

    params = { "cluster-devices": {"device-id-list": device_id_list,
        "uuid": uuid,} }

    params[:"cluster-devices"].each do |k, v|
        if not v
            params[:"cluster-devices"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cluster-devices"].each do |k, v|
        if v != params[:"cluster-devices"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cluster-devices') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/cluster-devices"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cluster-devices') do
            client.delete(url)
        end
    end
end