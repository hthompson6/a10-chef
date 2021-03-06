resource_name :a10_snmp_server_host_ipv6_host

property :a10_name, String, name_property: true
property :uuid, String
property :ipv6_addr, String,required: true
property :udp_port, Integer
property :v1_v2c_comm, String
property :user, String
property :version, ['v1','v2c','v3'],required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/host/ipv6-host/"
    get_url = "/axapi/v3/snmp-server/host/ipv6-host/%<ipv6-addr>s+%<version>s"
    uuid = new_resource.uuid
    ipv6_addr = new_resource.ipv6_addr
    udp_port = new_resource.udp_port
    v1_v2c_comm = new_resource.v1_v2c_comm
    user = new_resource.user
    version = new_resource.version

    params = { "ipv6-host": {"uuid": uuid,
        "ipv6-addr": ipv6_addr,
        "udp-port": udp_port,
        "v1-v2c-comm": v1_v2c_comm,
        "user": user,
        "version": version,} }

    params[:"ipv6-host"].each do |k, v|
        if not v 
            params[:"ipv6-host"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6-host') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/host/ipv6-host/%<ipv6-addr>s+%<version>s"
    uuid = new_resource.uuid
    ipv6_addr = new_resource.ipv6_addr
    udp_port = new_resource.udp_port
    v1_v2c_comm = new_resource.v1_v2c_comm
    user = new_resource.user
    version = new_resource.version

    params = { "ipv6-host": {"uuid": uuid,
        "ipv6-addr": ipv6_addr,
        "udp-port": udp_port,
        "v1-v2c-comm": v1_v2c_comm,
        "user": user,
        "version": version,} }

    params[:"ipv6-host"].each do |k, v|
        if not v
            params[:"ipv6-host"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6-host"].each do |k, v|
        if v != params[:"ipv6-host"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6-host') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/host/ipv6-host/%<ipv6-addr>s+%<version>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6-host') do
            client.delete(url)
        end
    end
end