resource_name :a10_cgnv6_nat_icmpv6

property :a10_name, String, name_property: true
property :respond_to_ping, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat/"
    get_url = "/axapi/v3/cgnv6/nat/icmpv6"
    respond_to_ping = new_resource.respond_to_ping
    uuid = new_resource.uuid

    params = { "icmpv6": {"respond-to-ping": respond_to_ping,
        "uuid": uuid,} }

    params[:"icmpv6"].each do |k, v|
        if not v 
            params[:"icmpv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating icmpv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/icmpv6"
    respond_to_ping = new_resource.respond_to_ping
    uuid = new_resource.uuid

    params = { "icmpv6": {"respond-to-ping": respond_to_ping,
        "uuid": uuid,} }

    params[:"icmpv6"].each do |k, v|
        if not v
            params[:"icmpv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["icmpv6"].each do |k, v|
        if v != params[:"icmpv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating icmpv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/icmpv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting icmpv6') do
            client.delete(url)
        end
    end
end