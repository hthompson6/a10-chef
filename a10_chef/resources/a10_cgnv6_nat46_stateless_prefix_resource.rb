resource_name :a10_cgnv6_nat46_stateless_prefix

property :a10_name, String, name_property: true
property :ipv6_prefix, String
property :vrid, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat46-stateless/"
    get_url = "/axapi/v3/cgnv6/nat46-stateless/prefix"
    ipv6_prefix = new_resource.ipv6_prefix
    vrid = new_resource.vrid
    uuid = new_resource.uuid

    params = { "prefix": {"ipv6-prefix": ipv6_prefix,
        "vrid": vrid,
        "uuid": uuid,} }

    params[:"prefix"].each do |k, v|
        if not v 
            params[:"prefix"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating prefix') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/prefix"
    ipv6_prefix = new_resource.ipv6_prefix
    vrid = new_resource.vrid
    uuid = new_resource.uuid

    params = { "prefix": {"ipv6-prefix": ipv6_prefix,
        "vrid": vrid,
        "uuid": uuid,} }

    params[:"prefix"].each do |k, v|
        if not v
            params[:"prefix"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["prefix"].each do |k, v|
        if v != params[:"prefix"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating prefix') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/prefix"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting prefix') do
            client.delete(url)
        end
    end
end