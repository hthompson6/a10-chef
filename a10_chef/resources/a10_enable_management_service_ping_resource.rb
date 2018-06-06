resource_name :a10_enable_management_service_ping

property :a10_name, String, name_property: true
property :acl_v6_list, Array
property :uuid, String
property :acl_v4_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/enable-management/service/"
    get_url = "/axapi/v3/enable-management/service/ping"
    acl_v6_list = new_resource.acl_v6_list
    uuid = new_resource.uuid
    acl_v4_list = new_resource.acl_v4_list

    params = { "ping": {"acl-v6-list": acl_v6_list,
        "uuid": uuid,
        "acl-v4-list": acl_v4_list,} }

    params[:"ping"].each do |k, v|
        if not v 
            params[:"ping"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ping') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/ping"
    acl_v6_list = new_resource.acl_v6_list
    uuid = new_resource.uuid
    acl_v4_list = new_resource.acl_v4_list

    params = { "ping": {"acl-v6-list": acl_v6_list,
        "uuid": uuid,
        "acl-v4-list": acl_v4_list,} }

    params[:"ping"].each do |k, v|
        if not v
            params[:"ping"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ping"].each do |k, v|
        if v != params[:"ping"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ping') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/ping"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ping') do
            client.delete(url)
        end
    end
end