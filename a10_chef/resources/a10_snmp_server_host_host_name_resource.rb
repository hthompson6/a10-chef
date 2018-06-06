resource_name :a10_snmp_server_host_host_name

property :a10_name, String, name_property: true
property :uuid, String
property :hostname, String,required: true
property :udp_port, Integer
property :v1_v2c_comm, String
property :user, String
property :version, ['v1','v2c','v3'],required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/host/host-name/"
    get_url = "/axapi/v3/snmp-server/host/host-name/%<hostname>s+%<version>s"
    uuid = new_resource.uuid
    hostname = new_resource.hostname
    udp_port = new_resource.udp_port
    v1_v2c_comm = new_resource.v1_v2c_comm
    user = new_resource.user
    version = new_resource.version

    params = { "host-name": {"uuid": uuid,
        "hostname": hostname,
        "udp-port": udp_port,
        "v1-v2c-comm": v1_v2c_comm,
        "user": user,
        "version": version,} }

    params[:"host-name"].each do |k, v|
        if not v 
            params[:"host-name"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating host-name') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/host/host-name/%<hostname>s+%<version>s"
    uuid = new_resource.uuid
    hostname = new_resource.hostname
    udp_port = new_resource.udp_port
    v1_v2c_comm = new_resource.v1_v2c_comm
    user = new_resource.user
    version = new_resource.version

    params = { "host-name": {"uuid": uuid,
        "hostname": hostname,
        "udp-port": udp_port,
        "v1-v2c-comm": v1_v2c_comm,
        "user": user,
        "version": version,} }

    params[:"host-name"].each do |k, v|
        if not v
            params[:"host-name"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["host-name"].each do |k, v|
        if v != params[:"host-name"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating host-name') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/host/host-name/%<hostname>s+%<version>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting host-name') do
            client.delete(url)
        end
    end
end