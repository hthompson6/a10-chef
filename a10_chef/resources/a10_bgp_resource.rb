resource_name :a10_bgp

property :a10_name, String, name_property: true
property :nexthop_trigger, Hash
property :extended_asn_cap, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/bgp"
    nexthop_trigger = new_resource.nexthop_trigger
    extended_asn_cap = new_resource.extended_asn_cap
    uuid = new_resource.uuid

    params = { "bgp": {"nexthop-trigger": nexthop_trigger,
        "extended-asn-cap": extended_asn_cap,
        "uuid": uuid,} }

    params[:"bgp"].each do |k, v|
        if not v 
            params[:"bgp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bgp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/bgp"
    nexthop_trigger = new_resource.nexthop_trigger
    extended_asn_cap = new_resource.extended_asn_cap
    uuid = new_resource.uuid

    params = { "bgp": {"nexthop-trigger": nexthop_trigger,
        "extended-asn-cap": extended_asn_cap,
        "uuid": uuid,} }

    params[:"bgp"].each do |k, v|
        if not v
            params[:"bgp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bgp"].each do |k, v|
        if v != params[:"bgp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bgp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/bgp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bgp') do
            client.delete(url)
        end
    end
end