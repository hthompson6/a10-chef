resource_name :a10_slb_resource_usage

property :a10_name, String, name_property: true
property :proxy_template_count, Integer
property :nat_pool_addr_count, Integer
property :fast_tcp_template_count, Integer
property :virtual_port_count, Integer
property :health_monitor_count, Integer
property :fast_udp_template_count, Integer
property :persist_srcip_template_count, Integer
property :client_ssl_template_count, Integer
property :server_ssl_template_count, Integer
property :http_template_count, Integer
property :pbslb_subnet_count, Integer
property :persist_cookie_template_count, Integer
property :virtual_server_count, Integer
property :stream_template_count, Integer
property :conn_reuse_template_count, Integer
property :real_server_count, Integer
property :real_port_count, Integer
property :service_group_count, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/resource-usage"
    proxy_template_count = new_resource.proxy_template_count
    nat_pool_addr_count = new_resource.nat_pool_addr_count
    fast_tcp_template_count = new_resource.fast_tcp_template_count
    virtual_port_count = new_resource.virtual_port_count
    health_monitor_count = new_resource.health_monitor_count
    fast_udp_template_count = new_resource.fast_udp_template_count
    persist_srcip_template_count = new_resource.persist_srcip_template_count
    client_ssl_template_count = new_resource.client_ssl_template_count
    server_ssl_template_count = new_resource.server_ssl_template_count
    http_template_count = new_resource.http_template_count
    pbslb_subnet_count = new_resource.pbslb_subnet_count
    persist_cookie_template_count = new_resource.persist_cookie_template_count
    virtual_server_count = new_resource.virtual_server_count
    stream_template_count = new_resource.stream_template_count
    conn_reuse_template_count = new_resource.conn_reuse_template_count
    real_server_count = new_resource.real_server_count
    real_port_count = new_resource.real_port_count
    service_group_count = new_resource.service_group_count
    uuid = new_resource.uuid

    params = { "resource-usage": {"proxy-template-count": proxy_template_count,
        "nat-pool-addr-count": nat_pool_addr_count,
        "fast-tcp-template-count": fast_tcp_template_count,
        "virtual-port-count": virtual_port_count,
        "health-monitor-count": health_monitor_count,
        "fast-udp-template-count": fast_udp_template_count,
        "persist-srcip-template-count": persist_srcip_template_count,
        "client-ssl-template-count": client_ssl_template_count,
        "server-ssl-template-count": server_ssl_template_count,
        "http-template-count": http_template_count,
        "pbslb-subnet-count": pbslb_subnet_count,
        "persist-cookie-template-count": persist_cookie_template_count,
        "virtual-server-count": virtual_server_count,
        "stream-template-count": stream_template_count,
        "conn-reuse-template-count": conn_reuse_template_count,
        "real-server-count": real_server_count,
        "real-port-count": real_port_count,
        "service-group-count": service_group_count,
        "uuid": uuid,} }

    params[:"resource-usage"].each do |k, v|
        if not v 
            params[:"resource-usage"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating resource-usage') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/resource-usage"
    proxy_template_count = new_resource.proxy_template_count
    nat_pool_addr_count = new_resource.nat_pool_addr_count
    fast_tcp_template_count = new_resource.fast_tcp_template_count
    virtual_port_count = new_resource.virtual_port_count
    health_monitor_count = new_resource.health_monitor_count
    fast_udp_template_count = new_resource.fast_udp_template_count
    persist_srcip_template_count = new_resource.persist_srcip_template_count
    client_ssl_template_count = new_resource.client_ssl_template_count
    server_ssl_template_count = new_resource.server_ssl_template_count
    http_template_count = new_resource.http_template_count
    pbslb_subnet_count = new_resource.pbslb_subnet_count
    persist_cookie_template_count = new_resource.persist_cookie_template_count
    virtual_server_count = new_resource.virtual_server_count
    stream_template_count = new_resource.stream_template_count
    conn_reuse_template_count = new_resource.conn_reuse_template_count
    real_server_count = new_resource.real_server_count
    real_port_count = new_resource.real_port_count
    service_group_count = new_resource.service_group_count
    uuid = new_resource.uuid

    params = { "resource-usage": {"proxy-template-count": proxy_template_count,
        "nat-pool-addr-count": nat_pool_addr_count,
        "fast-tcp-template-count": fast_tcp_template_count,
        "virtual-port-count": virtual_port_count,
        "health-monitor-count": health_monitor_count,
        "fast-udp-template-count": fast_udp_template_count,
        "persist-srcip-template-count": persist_srcip_template_count,
        "client-ssl-template-count": client_ssl_template_count,
        "server-ssl-template-count": server_ssl_template_count,
        "http-template-count": http_template_count,
        "pbslb-subnet-count": pbslb_subnet_count,
        "persist-cookie-template-count": persist_cookie_template_count,
        "virtual-server-count": virtual_server_count,
        "stream-template-count": stream_template_count,
        "conn-reuse-template-count": conn_reuse_template_count,
        "real-server-count": real_server_count,
        "real-port-count": real_port_count,
        "service-group-count": service_group_count,
        "uuid": uuid,} }

    params[:"resource-usage"].each do |k, v|
        if not v
            params[:"resource-usage"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["resource-usage"].each do |k, v|
        if v != params[:"resource-usage"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating resource-usage') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/resource-usage"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting resource-usage') do
            client.delete(url)
        end
    end
end