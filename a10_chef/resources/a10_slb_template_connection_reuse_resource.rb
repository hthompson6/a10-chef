resource_name :a10_slb_template_connection_reuse

property :a10_name, String, name_property: true
property :preopen, [true, false]
property :uuid, String
property :keep_alive_conn, [true, false]
property :user_tag, String
property :limit_per_server, Integer
property :timeout, Integer
property :num_conn_per_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/connection-reuse/"
    get_url = "/axapi/v3/slb/template/connection-reuse/%<name>s"
    preopen = new_resource.preopen
    uuid = new_resource.uuid
    keep_alive_conn = new_resource.keep_alive_conn
    user_tag = new_resource.user_tag
    limit_per_server = new_resource.limit_per_server
    timeout = new_resource.timeout
    num_conn_per_port = new_resource.num_conn_per_port
    a10_name = new_resource.a10_name

    params = { "connection-reuse": {"preopen": preopen,
        "uuid": uuid,
        "keep-alive-conn": keep_alive_conn,
        "user-tag": user_tag,
        "limit-per-server": limit_per_server,
        "timeout": timeout,
        "num-conn-per-port": num_conn_per_port,
        "name": a10_name,} }

    params[:"connection-reuse"].each do |k, v|
        if not v 
            params[:"connection-reuse"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating connection-reuse') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/connection-reuse/%<name>s"
    preopen = new_resource.preopen
    uuid = new_resource.uuid
    keep_alive_conn = new_resource.keep_alive_conn
    user_tag = new_resource.user_tag
    limit_per_server = new_resource.limit_per_server
    timeout = new_resource.timeout
    num_conn_per_port = new_resource.num_conn_per_port
    a10_name = new_resource.a10_name

    params = { "connection-reuse": {"preopen": preopen,
        "uuid": uuid,
        "keep-alive-conn": keep_alive_conn,
        "user-tag": user_tag,
        "limit-per-server": limit_per_server,
        "timeout": timeout,
        "num-conn-per-port": num_conn_per_port,
        "name": a10_name,} }

    params[:"connection-reuse"].each do |k, v|
        if not v
            params[:"connection-reuse"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["connection-reuse"].each do |k, v|
        if v != params[:"connection-reuse"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating connection-reuse') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/connection-reuse/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting connection-reuse') do
            client.delete(url)
        end
    end
end