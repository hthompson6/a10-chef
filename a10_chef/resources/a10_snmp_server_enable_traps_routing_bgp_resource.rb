resource_name :a10_snmp_server_enable_traps_routing_bgp

property :a10_name, String, name_property: true
property :bgpEstablishedNotification, [true, false]
property :uuid, String
property :bgpBackwardTransNotification, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/routing/"
    get_url = "/axapi/v3/snmp-server/enable/traps/routing/bgp"
    bgpEstablishedNotification = new_resource.bgpEstablishedNotification
    uuid = new_resource.uuid
    bgpBackwardTransNotification = new_resource.bgpBackwardTransNotification

    params = { "bgp": {"bgpEstablishedNotification": bgpEstablishedNotification,
        "uuid": uuid,
        "bgpBackwardTransNotification": bgpBackwardTransNotification,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/routing/bgp"
    bgpEstablishedNotification = new_resource.bgpEstablishedNotification
    uuid = new_resource.uuid
    bgpBackwardTransNotification = new_resource.bgpBackwardTransNotification

    params = { "bgp": {"bgpEstablishedNotification": bgpEstablishedNotification,
        "uuid": uuid,
        "bgpBackwardTransNotification": bgpBackwardTransNotification,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/routing/bgp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bgp') do
            client.delete(url)
        end
    end
end