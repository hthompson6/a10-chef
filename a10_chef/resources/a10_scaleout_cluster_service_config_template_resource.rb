resource_name :a10_scaleout_cluster_service_config_template

property :a10_name, String, name_property: true
property :device_group, Integer
property :bucket_count, Integer
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/service-config/template/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/service-config/template/%<name>s"
    device_group = new_resource.device_group
    bucket_count = new_resource.bucket_count
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "template": {"device-group": device_group,
        "bucket-count": bucket_count,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/service-config/template/%<name>s"
    device_group = new_resource.device_group
    bucket_count = new_resource.bucket_count
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "template": {"device-group": device_group,
        "bucket-count": bucket_count,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/service-config/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end