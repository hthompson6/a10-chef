resource_name :a10_scaleout_cluster_device_groups_device_group

property :a10_name, String, name_property: true
property :device_group, Integer,required: true
property :device_id_list, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups/device-group/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups/device-group/%<device-group>s"
    device_group = new_resource.device_group
    device_id_list = new_resource.device_id_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "device-group": {"device-group": device_group,
        "device-id-list": device_id_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"device-group"].each do |k, v|
        if not v 
            params[:"device-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating device-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups/device-group/%<device-group>s"
    device_group = new_resource.device_group
    device_id_list = new_resource.device_id_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "device-group": {"device-group": device_group,
        "device-id-list": device_id_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"device-group"].each do |k, v|
        if not v
            params[:"device-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["device-group"].each do |k, v|
        if v != params[:"device-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating device-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/device-groups/device-group/%<device-group>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting device-group') do
            client.delete(url)
        end
    end
end