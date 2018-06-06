resource_name :a10_ip_nat_inside_source_list_acl_id_list

property :a10_name, String, name_property: true
property :msl, Integer
property :acl_id, Integer,required: true
property :uuid, String
property :pool, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/inside/source/list/acl-id-list/"
    get_url = "/axapi/v3/ip/nat/inside/source/list/acl-id-list/%<acl-id>s"
    msl = new_resource.msl
    acl_id = new_resource.acl_id
    uuid = new_resource.uuid
    pool = new_resource.pool

    params = { "acl-id-list": {"msl": msl,
        "acl-id": acl_id,
        "uuid": uuid,
        "pool": pool,} }

    params[:"acl-id-list"].each do |k, v|
        if not v 
            params[:"acl-id-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating acl-id-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/inside/source/list/acl-id-list/%<acl-id>s"
    msl = new_resource.msl
    acl_id = new_resource.acl_id
    uuid = new_resource.uuid
    pool = new_resource.pool

    params = { "acl-id-list": {"msl": msl,
        "acl-id": acl_id,
        "uuid": uuid,
        "pool": pool,} }

    params[:"acl-id-list"].each do |k, v|
        if not v
            params[:"acl-id-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["acl-id-list"].each do |k, v|
        if v != params[:"acl-id-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating acl-id-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/inside/source/list/acl-id-list/%<acl-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting acl-id-list') do
            client.delete(url)
        end
    end
end