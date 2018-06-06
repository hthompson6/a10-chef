resource_name :a10_scaleout_cluster_device_groups

property :a10_name, String, name_property: true
property :device_group_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups"
    device_group_list = new_resource.device_group_list
    uuid = new_resource.uuid

    params = { "device-groups": {"device-group-list": device_group_list,
        "uuid": uuid,} }

    params[:"device-groups"].each do |k, v|
        if not v 
            params[:"device-groups"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating device-groups') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups"
    device_group_list = new_resource.device_group_list
    uuid = new_resource.uuid

    params = { "device-groups": {"device-group-list": device_group_list,
        "uuid": uuid,} }

    params[:"device-groups"].each do |k, v|
        if not v
            params[:"device-groups"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["device-groups"].each do |k, v|
        if v != params[:"device-groups"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating device-groups') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting device-groups') do
            client.delete(url)
        end
    end
end