resource_name :a10_cgnv6_lsn_inside_source

property :a10_name, String, name_property: true
property :uuid, String
property :class_list, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/inside/"
    get_url = "/axapi/v3/cgnv6/lsn/inside/source"
    uuid = new_resource.uuid
    class_list = new_resource.class_list

    params = { "source": {"uuid": uuid,
        "class-list": class_list,} }

    params[:"source"].each do |k, v|
        if not v 
            params[:"source"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating source') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/inside/source"
    uuid = new_resource.uuid
    class_list = new_resource.class_list

    params = { "source": {"uuid": uuid,
        "class-list": class_list,} }

    params[:"source"].each do |k, v|
        if not v
            params[:"source"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["source"].each do |k, v|
        if v != params[:"source"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating source') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/inside/source"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting source') do
            client.delete(url)
        end
    end
end