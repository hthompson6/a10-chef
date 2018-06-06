resource_name :a10_debug_packet

property :a10_name, String, name_property: true
property :count, Integer
property :arp, [true, false]
property :all, [true, false]
property :uuid, String
property :ip, [true, false]
property :l4_protocol, [true, false]
property :detail, [true, false]
property :tcp, [true, false]
property :port_range, Integer
property :icmpv6, [true, false]
property :ipv4ad, String
property :neighbor, [true, false]
property :ipv6, [true, false]
property :interface, [true, false]
property :ethernet, String
property :icmp, [true, false]
property :udp, [true, false]
property :ipv6ad, String
property :l3_protocol, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/packet"
    count = new_resource.count
    arp = new_resource.arp
    all = new_resource.all
    uuid = new_resource.uuid
    ip = new_resource.ip
    l4_protocol = new_resource.l4_protocol
    detail = new_resource.detail
    tcp = new_resource.tcp
    port_range = new_resource.port_range
    icmpv6 = new_resource.icmpv6
    ipv4ad = new_resource.ipv4ad
    neighbor = new_resource.neighbor
    ipv6 = new_resource.ipv6
    interface = new_resource.interface
    ethernet = new_resource.ethernet
    icmp = new_resource.icmp
    udp = new_resource.udp
    ipv6ad = new_resource.ipv6ad
    l3_protocol = new_resource.l3_protocol

    params = { "packet": {"count": count,
        "arp": arp,
        "all": all,
        "uuid": uuid,
        "ip": ip,
        "l4-protocol": l4_protocol,
        "detail": detail,
        "tcp": tcp,
        "port-range": port_range,
        "icmpv6": icmpv6,
        "ipv4ad": ipv4ad,
        "neighbor": neighbor,
        "ipv6": ipv6,
        "interface": interface,
        "ethernet": ethernet,
        "icmp": icmp,
        "udp": udp,
        "ipv6ad": ipv6ad,
        "l3-protocol": l3_protocol,} }

    params[:"packet"].each do |k, v|
        if not v 
            params[:"packet"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating packet') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/packet"
    count = new_resource.count
    arp = new_resource.arp
    all = new_resource.all
    uuid = new_resource.uuid
    ip = new_resource.ip
    l4_protocol = new_resource.l4_protocol
    detail = new_resource.detail
    tcp = new_resource.tcp
    port_range = new_resource.port_range
    icmpv6 = new_resource.icmpv6
    ipv4ad = new_resource.ipv4ad
    neighbor = new_resource.neighbor
    ipv6 = new_resource.ipv6
    interface = new_resource.interface
    ethernet = new_resource.ethernet
    icmp = new_resource.icmp
    udp = new_resource.udp
    ipv6ad = new_resource.ipv6ad
    l3_protocol = new_resource.l3_protocol

    params = { "packet": {"count": count,
        "arp": arp,
        "all": all,
        "uuid": uuid,
        "ip": ip,
        "l4-protocol": l4_protocol,
        "detail": detail,
        "tcp": tcp,
        "port-range": port_range,
        "icmpv6": icmpv6,
        "ipv4ad": ipv4ad,
        "neighbor": neighbor,
        "ipv6": ipv6,
        "interface": interface,
        "ethernet": ethernet,
        "icmp": icmp,
        "udp": udp,
        "ipv6ad": ipv6ad,
        "l3-protocol": l3_protocol,} }

    params[:"packet"].each do |k, v|
        if not v
            params[:"packet"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["packet"].each do |k, v|
        if v != params[:"packet"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating packet') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/packet"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting packet') do
            client.delete(url)
        end
    end
end