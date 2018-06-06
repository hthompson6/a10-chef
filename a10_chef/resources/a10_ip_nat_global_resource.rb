resource_name :a10_ip_nat_global

property :a10_name, String, name_property: true
property :uuid, String
property :reset_idle_tcp_conn, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/nat-global"
    uuid = new_resource.uuid
    reset_idle_tcp_conn = new_resource.reset_idle_tcp_conn

    params = { "nat-global": {"uuid": uuid,
        "reset-idle-tcp-conn": reset_idle_tcp_conn,} }

    params[:"nat-global"].each do |k, v|
        if not v 
            params[:"nat-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nat-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat-global"
    uuid = new_resource.uuid
    reset_idle_tcp_conn = new_resource.reset_idle_tcp_conn

    params = { "nat-global": {"uuid": uuid,
        "reset-idle-tcp-conn": reset_idle_tcp_conn,} }

    params[:"nat-global"].each do |k, v|
        if not v
            params[:"nat-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nat-global"].each do |k, v|
        if v != params[:"nat-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nat-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nat-global') do
            client.delete(url)
        end
    end
end