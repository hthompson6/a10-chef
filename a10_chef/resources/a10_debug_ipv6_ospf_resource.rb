resource_name :a10_debug_ipv6_ospf

property :a10_name, String, name_property: true
property :all, Hash
property :ifsm, Hash
property :bfd, Hash
property :route, Hash
property :lsa, Hash
property :nfsm, Hash
property :packet, Hash
property :a10_events, Hash
property :nsm, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ipv6/"
    get_url = "/axapi/v3/debug/ipv6/ospf"
    all = new_resource.all
    ifsm = new_resource.ifsm
    bfd = new_resource.bfd
    route = new_resource.route
    lsa = new_resource.lsa
    nfsm = new_resource.nfsm
    packet = new_resource.packet
    a10_name = new_resource.a10_name
    nsm = new_resource.nsm

    params = { "ospf": {"all": all,
        "ifsm": ifsm,
        "bfd": bfd,
        "route": route,
        "lsa": lsa,
        "nfsm": nfsm,
        "packet": packet,
        "events": a10_events,
        "nsm": nsm,} }

    params[:"ospf"].each do |k, v|
        if not v 
            params[:"ospf"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf"
    all = new_resource.all
    ifsm = new_resource.ifsm
    bfd = new_resource.bfd
    route = new_resource.route
    lsa = new_resource.lsa
    nfsm = new_resource.nfsm
    packet = new_resource.packet
    a10_name = new_resource.a10_name
    nsm = new_resource.nsm

    params = { "ospf": {"all": all,
        "ifsm": ifsm,
        "bfd": bfd,
        "route": route,
        "lsa": lsa,
        "nfsm": nfsm,
        "packet": packet,
        "events": a10_events,
        "nsm": nsm,} }

    params[:"ospf"].each do |k, v|
        if not v
            params[:"ospf"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf"].each do |k, v|
        if v != params[:"ospf"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end