resource_name :a10_ip_mgmt_traffic

property :a10_name, String, name_property: true
property :traffic_type, ['all','ftp','ntp','snmp-trap','ssh','syslog','telnet','tftp','web'],required: true
property :source_interface, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/mgmt-traffic/"
    get_url = "/axapi/v3/ip/mgmt-traffic/%<traffic-type>s"
    traffic_type = new_resource.traffic_type
    source_interface = new_resource.source_interface
    uuid = new_resource.uuid

    params = { "mgmt-traffic": {"traffic-type": traffic_type,
        "source-interface": source_interface,
        "uuid": uuid,} }

    params[:"mgmt-traffic"].each do |k, v|
        if not v 
            params[:"mgmt-traffic"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mgmt-traffic') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/mgmt-traffic/%<traffic-type>s"
    traffic_type = new_resource.traffic_type
    source_interface = new_resource.source_interface
    uuid = new_resource.uuid

    params = { "mgmt-traffic": {"traffic-type": traffic_type,
        "source-interface": source_interface,
        "uuid": uuid,} }

    params[:"mgmt-traffic"].each do |k, v|
        if not v
            params[:"mgmt-traffic"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mgmt-traffic"].each do |k, v|
        if v != params[:"mgmt-traffic"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mgmt-traffic') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/mgmt-traffic/%<traffic-type>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mgmt-traffic') do
            client.delete(url)
        end
    end
end