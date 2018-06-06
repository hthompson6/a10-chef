resource_name :a10_snmp_server_enable_traps_slb_change

property :a10_name, String, name_property: true
property :all, [true, false]
property :resource_usage_warning, [true, false]
property :uuid, String
property :ssl_cert_change, [true, false]
property :ssl_cert_expire, [true, false]
property :server, [true, false]
property :vip, [true, false]
property :connection_resource_event, [true, false]
property :server_port, [true, false]
property :vip_port, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/slb-change"
    all = new_resource.all
    resource_usage_warning = new_resource.resource_usage_warning
    uuid = new_resource.uuid
    ssl_cert_change = new_resource.ssl_cert_change
    ssl_cert_expire = new_resource.ssl_cert_expire
    server = new_resource.server
    vip = new_resource.vip
    connection_resource_event = new_resource.connection_resource_event
    server_port = new_resource.server_port
    vip_port = new_resource.vip_port

    params = { "slb-change": {"all": all,
        "resource-usage-warning": resource_usage_warning,
        "uuid": uuid,
        "ssl-cert-change": ssl_cert_change,
        "ssl-cert-expire": ssl_cert_expire,
        "server": server,
        "vip": vip,
        "connection-resource-event": connection_resource_event,
        "server-port": server_port,
        "vip-port": vip_port,} }

    params[:"slb-change"].each do |k, v|
        if not v 
            params[:"slb-change"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating slb-change') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/slb-change"
    all = new_resource.all
    resource_usage_warning = new_resource.resource_usage_warning
    uuid = new_resource.uuid
    ssl_cert_change = new_resource.ssl_cert_change
    ssl_cert_expire = new_resource.ssl_cert_expire
    server = new_resource.server
    vip = new_resource.vip
    connection_resource_event = new_resource.connection_resource_event
    server_port = new_resource.server_port
    vip_port = new_resource.vip_port

    params = { "slb-change": {"all": all,
        "resource-usage-warning": resource_usage_warning,
        "uuid": uuid,
        "ssl-cert-change": ssl_cert_change,
        "ssl-cert-expire": ssl_cert_expire,
        "server": server,
        "vip": vip,
        "connection-resource-event": connection_resource_event,
        "server-port": server_port,
        "vip-port": vip_port,} }

    params[:"slb-change"].each do |k, v|
        if not v
            params[:"slb-change"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["slb-change"].each do |k, v|
        if v != params[:"slb-change"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating slb-change') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/slb-change"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting slb-change') do
            client.delete(url)
        end
    end
end