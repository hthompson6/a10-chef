resource_name :a10_ip_nat_inside_source_list_acl_name_list

property :a10_name, String, name_property: true
property :msl, Integer
property :pool, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/inside/source/list/acl-name-list/"
    get_url = "/axapi/v3/ip/nat/inside/source/list/acl-name-list/%<name>s"
    msl = new_resource.msl
    a10_name = new_resource.a10_name
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "acl-name-list": {"msl": msl,
        "name": a10_name,
        "pool": pool,
        "uuid": uuid,} }

    params[:"acl-name-list"].each do |k, v|
        if not v 
            params[:"acl-name-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating acl-name-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/inside/source/list/acl-name-list/%<name>s"
    msl = new_resource.msl
    a10_name = new_resource.a10_name
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "acl-name-list": {"msl": msl,
        "name": a10_name,
        "pool": pool,
        "uuid": uuid,} }

    params[:"acl-name-list"].each do |k, v|
        if not v
            params[:"acl-name-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["acl-name-list"].each do |k, v|
        if v != params[:"acl-name-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating acl-name-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/inside/source/list/acl-name-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting acl-name-list') do
            client.delete(url)
        end
    end
end