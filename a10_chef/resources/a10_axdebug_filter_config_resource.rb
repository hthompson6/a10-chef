resource_name :a10_axdebug_filter_config

property :a10_name, String, name_property: true
property :arp, [true, false]
property :ip, [true, false]
property :offset, Integer
property :number, Integer,required: true
property :tcp, [true, false]
property :l3_proto, [true, false]
property :ipv4_address, String
property :port, [true, false]
property :port_num_min, Integer
property :oper_range, ['gt','gte','se','st','eq']
property :ipv6_adddress, String
property :WORD, String
property :comp_hex, String
property :proto, [true, false]
property :dst, [true, false]
property :hex, [true, false]
property :integer_comp, Integer
property :port_num_max, Integer
property :exit, [true, false]
property :ipv6, [true, false]
property :length, Integer
property :udp, [true, false]
property :neighbor, [true, false]
property :port_num, Integer
property :max_hex, String
property :mac, [true, false]
property :min_hex, String
property :WORD1, String
property :WORD2, String
property :integer_max, Integer
property :integer, [true, false]
property :icmp, [true, false]
property :src, [true, false]
property :mac_addr, String
property :ipv4_netmask, String
property :icmpv6, [true, false]
property :range, [true, false]
property :integer_min, Integer
property :prot_num, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/axdebug/"
    get_url = "/axapi/v3/axdebug/filter-config"
    arp = new_resource.arp
    ip = new_resource.ip
    offset = new_resource.offset
    number = new_resource.number
    tcp = new_resource.tcp
    l3_proto = new_resource.l3_proto
    ipv4_address = new_resource.ipv4_address
    port = new_resource.port
    port_num_min = new_resource.port_num_min
    oper_range = new_resource.oper_range
    ipv6_adddress = new_resource.ipv6_adddress
    WORD = new_resource.WORD
    comp_hex = new_resource.comp_hex
    proto = new_resource.proto
    dst = new_resource.dst
    hex = new_resource.hex
    integer_comp = new_resource.integer_comp
    port_num_max = new_resource.port_num_max
    exit = new_resource.exit
    ipv6 = new_resource.ipv6
    length = new_resource.length
    udp = new_resource.udp
    neighbor = new_resource.neighbor
    port_num = new_resource.port_num
    max_hex = new_resource.max_hex
    mac = new_resource.mac
    min_hex = new_resource.min_hex
    WORD1 = new_resource.WORD1
    WORD2 = new_resource.WORD2
    integer_max = new_resource.integer_max
    integer = new_resource.integer
    icmp = new_resource.icmp
    src = new_resource.src
    mac_addr = new_resource.mac_addr
    ipv4_netmask = new_resource.ipv4_netmask
    icmpv6 = new_resource.icmpv6
    range = new_resource.range
    integer_min = new_resource.integer_min
    prot_num = new_resource.prot_num

    params = { "filter-config": {"arp": arp,
        "ip": ip,
        "offset": offset,
        "number": number,
        "tcp": tcp,
        "l3-proto": l3_proto,
        "ipv4-address": ipv4_address,
        "port": port,
        "port-num-min": port_num_min,
        "oper-range": oper_range,
        "ipv6-adddress": ipv6_adddress,
        "WORD": WORD,
        "comp-hex": comp_hex,
        "proto": proto,
        "dst": dst,
        "hex": hex,
        "integer-comp": integer_comp,
        "port-num-max": port_num_max,
        "exit": exit,
        "ipv6": ipv6,
        "length": length,
        "udp": udp,
        "neighbor": neighbor,
        "port-num": port_num,
        "max-hex": max_hex,
        "mac": mac,
        "min-hex": min_hex,
        "WORD1": WORD1,
        "WORD2": WORD2,
        "integer-max": integer_max,
        "integer": integer,
        "icmp": icmp,
        "src": src,
        "mac-addr": mac_addr,
        "ipv4-netmask": ipv4_netmask,
        "icmpv6": icmpv6,
        "range": range,
        "integer-min": integer_min,
        "prot-num": prot_num,} }

    params[:"filter-config"].each do |k, v|
        if not v 
            params[:"filter-config"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating filter-config') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug/filter-config"
    arp = new_resource.arp
    ip = new_resource.ip
    offset = new_resource.offset
    number = new_resource.number
    tcp = new_resource.tcp
    l3_proto = new_resource.l3_proto
    ipv4_address = new_resource.ipv4_address
    port = new_resource.port
    port_num_min = new_resource.port_num_min
    oper_range = new_resource.oper_range
    ipv6_adddress = new_resource.ipv6_adddress
    WORD = new_resource.WORD
    comp_hex = new_resource.comp_hex
    proto = new_resource.proto
    dst = new_resource.dst
    hex = new_resource.hex
    integer_comp = new_resource.integer_comp
    port_num_max = new_resource.port_num_max
    exit = new_resource.exit
    ipv6 = new_resource.ipv6
    length = new_resource.length
    udp = new_resource.udp
    neighbor = new_resource.neighbor
    port_num = new_resource.port_num
    max_hex = new_resource.max_hex
    mac = new_resource.mac
    min_hex = new_resource.min_hex
    WORD1 = new_resource.WORD1
    WORD2 = new_resource.WORD2
    integer_max = new_resource.integer_max
    integer = new_resource.integer
    icmp = new_resource.icmp
    src = new_resource.src
    mac_addr = new_resource.mac_addr
    ipv4_netmask = new_resource.ipv4_netmask
    icmpv6 = new_resource.icmpv6
    range = new_resource.range
    integer_min = new_resource.integer_min
    prot_num = new_resource.prot_num

    params = { "filter-config": {"arp": arp,
        "ip": ip,
        "offset": offset,
        "number": number,
        "tcp": tcp,
        "l3-proto": l3_proto,
        "ipv4-address": ipv4_address,
        "port": port,
        "port-num-min": port_num_min,
        "oper-range": oper_range,
        "ipv6-adddress": ipv6_adddress,
        "WORD": WORD,
        "comp-hex": comp_hex,
        "proto": proto,
        "dst": dst,
        "hex": hex,
        "integer-comp": integer_comp,
        "port-num-max": port_num_max,
        "exit": exit,
        "ipv6": ipv6,
        "length": length,
        "udp": udp,
        "neighbor": neighbor,
        "port-num": port_num,
        "max-hex": max_hex,
        "mac": mac,
        "min-hex": min_hex,
        "WORD1": WORD1,
        "WORD2": WORD2,
        "integer-max": integer_max,
        "integer": integer,
        "icmp": icmp,
        "src": src,
        "mac-addr": mac_addr,
        "ipv4-netmask": ipv4_netmask,
        "icmpv6": icmpv6,
        "range": range,
        "integer-min": integer_min,
        "prot-num": prot_num,} }

    params[:"filter-config"].each do |k, v|
        if not v
            params[:"filter-config"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["filter-config"].each do |k, v|
        if v != params[:"filter-config"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating filter-config') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug/filter-config"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting filter-config') do
            client.delete(url)
        end
    end
end