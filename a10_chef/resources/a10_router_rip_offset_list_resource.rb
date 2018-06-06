resource_name :a10_router_rip_offset_list

property :a10_name, String, name_property: true
property :acl_cfg, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/rip/"
    get_url = "/axapi/v3/router/rip/offset-list"
    acl_cfg = new_resource.acl_cfg
    uuid = new_resource.uuid

    params = { "offset-list": {"acl-cfg": acl_cfg,
        "uuid": uuid,} }

    params[:"offset-list"].each do |k, v|
        if not v 
            params[:"offset-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating offset-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/rip/offset-list"
    acl_cfg = new_resource.acl_cfg
    uuid = new_resource.uuid

    params = { "offset-list": {"acl-cfg": acl_cfg,
        "uuid": uuid,} }

    params[:"offset-list"].each do |k, v|
        if not v
            params[:"offset-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["offset-list"].each do |k, v|
        if v != params[:"offset-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating offset-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/rip/offset-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting offset-list') do
            client.delete(url)
        end
    end
end