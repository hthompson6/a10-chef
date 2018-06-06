resource_name :a10_slb_template_tcp

property :a10_name, String, name_property: true
property :del_session_on_server_down, [true, false]
property :initial_window_size, Integer
property :half_open_idle_timeout, Integer
property :logging, ['init','term','both']
property :reset_fwd, [true, false]
property :alive_if_active, [true, false]
property :idle_timeout, Integer
property :force_delete_timeout, Integer
property :user_tag, String
property :down, [true, false]
property :disable, [true, false]
property :reset_rev, [true, false]
property :insert_client_ip, [true, false]
property :lan_fast_ack, [true, false]
property :half_close_idle_timeout, Integer
property :force_delete_timeout_100ms, Integer
property :qos, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/tcp/"
    get_url = "/axapi/v3/slb/template/tcp/%<name>s"
    del_session_on_server_down = new_resource.del_session_on_server_down
    initial_window_size = new_resource.initial_window_size
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    logging = new_resource.logging
    a10_name = new_resource.a10_name
    reset_fwd = new_resource.reset_fwd
    alive_if_active = new_resource.alive_if_active
    idle_timeout = new_resource.idle_timeout
    force_delete_timeout = new_resource.force_delete_timeout
    user_tag = new_resource.user_tag
    down = new_resource.down
    disable = new_resource.disable
    reset_rev = new_resource.reset_rev
    insert_client_ip = new_resource.insert_client_ip
    lan_fast_ack = new_resource.lan_fast_ack
    half_close_idle_timeout = new_resource.half_close_idle_timeout
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    qos = new_resource.qos
    uuid = new_resource.uuid

    params = { "tcp": {"del-session-on-server-down": del_session_on_server_down,
        "initial-window-size": initial_window_size,
        "half-open-idle-timeout": half_open_idle_timeout,
        "logging": logging,
        "name": a10_name,
        "reset-fwd": reset_fwd,
        "alive-if-active": alive_if_active,
        "idle-timeout": idle_timeout,
        "force-delete-timeout": force_delete_timeout,
        "user-tag": user_tag,
        "down": down,
        "disable": disable,
        "reset-rev": reset_rev,
        "insert-client-ip": insert_client_ip,
        "lan-fast-ack": lan_fast_ack,
        "half-close-idle-timeout": half_close_idle_timeout,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "qos": qos,
        "uuid": uuid,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/tcp/%<name>s"
    del_session_on_server_down = new_resource.del_session_on_server_down
    initial_window_size = new_resource.initial_window_size
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    logging = new_resource.logging
    a10_name = new_resource.a10_name
    reset_fwd = new_resource.reset_fwd
    alive_if_active = new_resource.alive_if_active
    idle_timeout = new_resource.idle_timeout
    force_delete_timeout = new_resource.force_delete_timeout
    user_tag = new_resource.user_tag
    down = new_resource.down
    disable = new_resource.disable
    reset_rev = new_resource.reset_rev
    insert_client_ip = new_resource.insert_client_ip
    lan_fast_ack = new_resource.lan_fast_ack
    half_close_idle_timeout = new_resource.half_close_idle_timeout
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    qos = new_resource.qos
    uuid = new_resource.uuid

    params = { "tcp": {"del-session-on-server-down": del_session_on_server_down,
        "initial-window-size": initial_window_size,
        "half-open-idle-timeout": half_open_idle_timeout,
        "logging": logging,
        "name": a10_name,
        "reset-fwd": reset_fwd,
        "alive-if-active": alive_if_active,
        "idle-timeout": idle_timeout,
        "force-delete-timeout": force_delete_timeout,
        "user-tag": user_tag,
        "down": down,
        "disable": disable,
        "reset-rev": reset_rev,
        "insert-client-ip": insert_client_ip,
        "lan-fast-ack": lan_fast_ack,
        "half-close-idle-timeout": half_close_idle_timeout,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "qos": qos,
        "uuid": uuid,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/tcp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end