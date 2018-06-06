resource_name :a10_snmp_server_enable_traps_lsn

property :a10_name, String, name_property: true
property :all, [true, false]
property :fixed_nat_port_mapping_file_change, [true, false]
property :per_ip_port_usage_threshold, [true, false]
property :uuid, String
property :total_port_usage_threshold, [true, false]
property :max_port_threshold, Integer
property :max_ipport_threshold, Integer
property :traffic_exceeded, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/lsn"
    all = new_resource.all
    fixed_nat_port_mapping_file_change = new_resource.fixed_nat_port_mapping_file_change
    per_ip_port_usage_threshold = new_resource.per_ip_port_usage_threshold
    uuid = new_resource.uuid
    total_port_usage_threshold = new_resource.total_port_usage_threshold
    max_port_threshold = new_resource.max_port_threshold
    max_ipport_threshold = new_resource.max_ipport_threshold
    traffic_exceeded = new_resource.traffic_exceeded

    params = { "lsn": {"all": all,
        "fixed-nat-port-mapping-file-change": fixed_nat_port_mapping_file_change,
        "per-ip-port-usage-threshold": per_ip_port_usage_threshold,
        "uuid": uuid,
        "total-port-usage-threshold": total_port_usage_threshold,
        "max-port-threshold": max_port_threshold,
        "max-ipport-threshold": max_ipport_threshold,
        "traffic-exceeded": traffic_exceeded,} }

    params[:"lsn"].each do |k, v|
        if not v 
            params[:"lsn"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lsn') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/lsn"
    all = new_resource.all
    fixed_nat_port_mapping_file_change = new_resource.fixed_nat_port_mapping_file_change
    per_ip_port_usage_threshold = new_resource.per_ip_port_usage_threshold
    uuid = new_resource.uuid
    total_port_usage_threshold = new_resource.total_port_usage_threshold
    max_port_threshold = new_resource.max_port_threshold
    max_ipport_threshold = new_resource.max_ipport_threshold
    traffic_exceeded = new_resource.traffic_exceeded

    params = { "lsn": {"all": all,
        "fixed-nat-port-mapping-file-change": fixed_nat_port_mapping_file_change,
        "per-ip-port-usage-threshold": per_ip_port_usage_threshold,
        "uuid": uuid,
        "total-port-usage-threshold": total_port_usage_threshold,
        "max-port-threshold": max_port_threshold,
        "max-ipport-threshold": max_ipport_threshold,
        "traffic-exceeded": traffic_exceeded,} }

    params[:"lsn"].each do |k, v|
        if not v
            params[:"lsn"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lsn"].each do |k, v|
        if v != params[:"lsn"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lsn') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/lsn"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lsn') do
            client.delete(url)
        end
    end
end