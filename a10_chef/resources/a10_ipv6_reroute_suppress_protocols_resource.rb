resource_name :a10_ipv6_reroute_suppress_protocols

property :a10_name, String, name_property: true
property :isis, [true, false]
property :uuid, String
property :ospf, [true, false]
property :rip, [true, false]
property :ibgp, [true, false]
property :ebgp, [true, false]
property :static, [true, false]
property :connected, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ipv6/reroute/"
    get_url = "/axapi/v3/ipv6/reroute/suppress-protocols"
    isis = new_resource.isis
    uuid = new_resource.uuid
    ospf = new_resource.ospf
    rip = new_resource.rip
    ibgp = new_resource.ibgp
    ebgp = new_resource.ebgp
    static = new_resource.static
    connected = new_resource.connected

    params = { "suppress-protocols": {"isis": isis,
        "uuid": uuid,
        "ospf": ospf,
        "rip": rip,
        "ibgp": ibgp,
        "ebgp": ebgp,
        "static": static,
        "connected": connected,} }

    params[:"suppress-protocols"].each do |k, v|
        if not v 
            params[:"suppress-protocols"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating suppress-protocols') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/reroute/suppress-protocols"
    isis = new_resource.isis
    uuid = new_resource.uuid
    ospf = new_resource.ospf
    rip = new_resource.rip
    ibgp = new_resource.ibgp
    ebgp = new_resource.ebgp
    static = new_resource.static
    connected = new_resource.connected

    params = { "suppress-protocols": {"isis": isis,
        "uuid": uuid,
        "ospf": ospf,
        "rip": rip,
        "ibgp": ibgp,
        "ebgp": ebgp,
        "static": static,
        "connected": connected,} }

    params[:"suppress-protocols"].each do |k, v|
        if not v
            params[:"suppress-protocols"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["suppress-protocols"].each do |k, v|
        if v != params[:"suppress-protocols"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating suppress-protocols') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ipv6/reroute/suppress-protocols"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting suppress-protocols') do
            client.delete(url)
        end
    end
end