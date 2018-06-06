resource_name :a10_web_category

property :a10_name, String, name_property: true
property :cloud_query_disable, [true, false]
property :rtu_update_interval, Integer
property :enable, [true, false]
property :use_mgmt_port, [true, false]
property :database_server, String
property :db_update_time, String
property :server_timeout, Integer
property :server, String
property :remote_syslog_enable, [true, false]
property :rtu_update_disable, [true, false]
property :proxy_server, Hash
property :category_list_list, Array
property :port, Integer
property :ssl_port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/web-category"
    cloud_query_disable = new_resource.cloud_query_disable
    rtu_update_interval = new_resource.rtu_update_interval
    enable = new_resource.enable
    use_mgmt_port = new_resource.use_mgmt_port
    database_server = new_resource.database_server
    db_update_time = new_resource.db_update_time
    server_timeout = new_resource.server_timeout
    server = new_resource.server
    remote_syslog_enable = new_resource.remote_syslog_enable
    rtu_update_disable = new_resource.rtu_update_disable
    proxy_server = new_resource.proxy_server
    category_list_list = new_resource.category_list_list
    port = new_resource.port
    ssl_port = new_resource.ssl_port
    uuid = new_resource.uuid

    params = { "web-category": {"cloud-query-disable": cloud_query_disable,
        "rtu-update-interval": rtu_update_interval,
        "enable": enable,
        "use-mgmt-port": use_mgmt_port,
        "database-server": database_server,
        "db-update-time": db_update_time,
        "server-timeout": server_timeout,
        "server": server,
        "remote-syslog-enable": remote_syslog_enable,
        "rtu-update-disable": rtu_update_disable,
        "proxy-server": proxy_server,
        "category-list-list": category_list_list,
        "port": port,
        "ssl-port": ssl_port,
        "uuid": uuid,} }

    params[:"web-category"].each do |k, v|
        if not v 
            params[:"web-category"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating web-category') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category"
    cloud_query_disable = new_resource.cloud_query_disable
    rtu_update_interval = new_resource.rtu_update_interval
    enable = new_resource.enable
    use_mgmt_port = new_resource.use_mgmt_port
    database_server = new_resource.database_server
    db_update_time = new_resource.db_update_time
    server_timeout = new_resource.server_timeout
    server = new_resource.server
    remote_syslog_enable = new_resource.remote_syslog_enable
    rtu_update_disable = new_resource.rtu_update_disable
    proxy_server = new_resource.proxy_server
    category_list_list = new_resource.category_list_list
    port = new_resource.port
    ssl_port = new_resource.ssl_port
    uuid = new_resource.uuid

    params = { "web-category": {"cloud-query-disable": cloud_query_disable,
        "rtu-update-interval": rtu_update_interval,
        "enable": enable,
        "use-mgmt-port": use_mgmt_port,
        "database-server": database_server,
        "db-update-time": db_update_time,
        "server-timeout": server_timeout,
        "server": server,
        "remote-syslog-enable": remote_syslog_enable,
        "rtu-update-disable": rtu_update_disable,
        "proxy-server": proxy_server,
        "category-list-list": category_list_list,
        "port": port,
        "ssl-port": ssl_port,
        "uuid": uuid,} }

    params[:"web-category"].each do |k, v|
        if not v
            params[:"web-category"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["web-category"].each do |k, v|
        if v != params[:"web-category"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating web-category') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting web-category') do
            client.delete(url)
        end
    end
end