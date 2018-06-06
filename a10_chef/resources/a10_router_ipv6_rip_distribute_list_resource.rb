resource_name :a10_router_ipv6_rip_distribute_list

property :a10_name, String, name_property: true
property :acl_cfg, Array
property :prefix, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ipv6/rip/"
    get_url = "/axapi/v3/router/ipv6/rip/distribute-list"
    acl_cfg = new_resource.acl_cfg
    prefix = new_resource.prefix
    uuid = new_resource.uuid

    params = { "distribute-list": {"acl-cfg": acl_cfg,
        "prefix": prefix,
        "uuid": uuid,} }

    params[:"distribute-list"].each do |k, v|
        if not v 
            params[:"distribute-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating distribute-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip/distribute-list"
    acl_cfg = new_resource.acl_cfg
    prefix = new_resource.prefix
    uuid = new_resource.uuid

    params = { "distribute-list": {"acl-cfg": acl_cfg,
        "prefix": prefix,
        "uuid": uuid,} }

    params[:"distribute-list"].each do |k, v|
        if not v
            params[:"distribute-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["distribute-list"].each do |k, v|
        if v != params[:"distribute-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating distribute-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip/distribute-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting distribute-list') do
            client.delete(url)
        end
    end
end