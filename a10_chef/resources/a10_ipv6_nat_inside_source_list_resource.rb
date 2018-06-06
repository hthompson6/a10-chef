resource_name :a10_ipv6_nat_inside_source_list

property :a10_name, String, name_property: true
property :list_name, String,required: true
property :pool, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/nat/inside/source/list/"
    get_url = "/axapi/v3/ipv6/nat/inside/source/list/%<list-name>s"
    list_name = new_resource.list_name
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "list": {"list-name": list_name,
        "pool": pool,
        "uuid": uuid,} }

    params[:"list"].each do |k, v|
        if not v 
            params[:"list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/nat/inside/source/list/%<list-name>s"
    list_name = new_resource.list_name
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "list": {"list-name": list_name,
        "pool": pool,
        "uuid": uuid,} }

    params[:"list"].each do |k, v|
        if not v
            params[:"list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["list"].each do |k, v|
        if v != params[:"list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/nat/inside/source/list/%<list-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting list') do
            client.delete(url)
        end
    end
end