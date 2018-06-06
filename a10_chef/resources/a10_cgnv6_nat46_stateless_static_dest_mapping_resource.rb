resource_name :a10_cgnv6_nat46_stateless_static_dest_mapping

property :a10_name, String, name_property: true
property :count, Integer
property :v6_address, String,required: true
property :uuid, String
property :to_shared, [true, false]
property :vrid, Integer
property :v4_address, String,required: true
property :shared, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat46-stateless/static-dest-mapping/"
    get_url = "/axapi/v3/cgnv6/nat46-stateless/static-dest-mapping/%<v4-address>s+%<v6-address>s"
    count = new_resource.count
    v6_address = new_resource.v6_address
    uuid = new_resource.uuid
    to_shared = new_resource.to_shared
    vrid = new_resource.vrid
    v4_address = new_resource.v4_address
    shared = new_resource.shared

    params = { "static-dest-mapping": {"count": count,
        "v6-address": v6_address,
        "uuid": uuid,
        "to-shared": to_shared,
        "vrid": vrid,
        "v4-address": v4_address,
        "shared": shared,} }

    params[:"static-dest-mapping"].each do |k, v|
        if not v 
            params[:"static-dest-mapping"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating static-dest-mapping') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/static-dest-mapping/%<v4-address>s+%<v6-address>s"
    count = new_resource.count
    v6_address = new_resource.v6_address
    uuid = new_resource.uuid
    to_shared = new_resource.to_shared
    vrid = new_resource.vrid
    v4_address = new_resource.v4_address
    shared = new_resource.shared

    params = { "static-dest-mapping": {"count": count,
        "v6-address": v6_address,
        "uuid": uuid,
        "to-shared": to_shared,
        "vrid": vrid,
        "v4-address": v4_address,
        "shared": shared,} }

    params[:"static-dest-mapping"].each do |k, v|
        if not v
            params[:"static-dest-mapping"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["static-dest-mapping"].each do |k, v|
        if v != params[:"static-dest-mapping"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating static-dest-mapping') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/static-dest-mapping/%<v4-address>s+%<v6-address>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static-dest-mapping') do
            client.delete(url)
        end
    end
end