resource_name :a10_scaleout_cluster_local_device

property :a10_name, String, name_property: true
property :priority, Integer
property :l2_redirect, Hash
property :id, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device"
    priority = new_resource.priority
    l2_redirect = new_resource.l2_redirect
    id = new_resource.id
    uuid = new_resource.uuid

    params = { "local-device": {"priority": priority,
        "l2-redirect": l2_redirect,
        "id": id,
        "uuid": uuid,} }

    params[:"local-device"].each do |k, v|
        if not v 
            params[:"local-device"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating local-device') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device"
    priority = new_resource.priority
    l2_redirect = new_resource.l2_redirect
    id = new_resource.id
    uuid = new_resource.uuid

    params = { "local-device": {"priority": priority,
        "l2-redirect": l2_redirect,
        "id": id,
        "uuid": uuid,} }

    params[:"local-device"].each do |k, v|
        if not v
            params[:"local-device"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["local-device"].each do |k, v|
        if v != params[:"local-device"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating local-device') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting local-device') do
            client.delete(url)
        end
    end
end