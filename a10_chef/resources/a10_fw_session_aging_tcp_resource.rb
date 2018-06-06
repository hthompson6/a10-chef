resource_name :a10_fw_session_aging_tcp

property :a10_name, String, name_property: true
property :uuid, String
property :tcp_idle_timeout, Integer
property :half_open_idle_timeout, Integer
property :force_delete_timeout, Integer
property :port_cfg, Array
property :force_delete_timeout_100ms, Integer
property :half_close_idle_timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/session-aging/%<name>s/"
    get_url = "/axapi/v3/fw/session-aging/%<name>s/tcp"
    uuid = new_resource.uuid
    tcp_idle_timeout = new_resource.tcp_idle_timeout
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    force_delete_timeout = new_resource.force_delete_timeout
    port_cfg = new_resource.port_cfg
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    half_close_idle_timeout = new_resource.half_close_idle_timeout

    params = { "tcp": {"uuid": uuid,
        "tcp-idle-timeout": tcp_idle_timeout,
        "half-open-idle-timeout": half_open_idle_timeout,
        "force-delete-timeout": force_delete_timeout,
        "port-cfg": port_cfg,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "half-close-idle-timeout": half_close_idle_timeout,} }

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
    url = "/axapi/v3/fw/session-aging/%<name>s/tcp"
    uuid = new_resource.uuid
    tcp_idle_timeout = new_resource.tcp_idle_timeout
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    force_delete_timeout = new_resource.force_delete_timeout
    port_cfg = new_resource.port_cfg
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    half_close_idle_timeout = new_resource.half_close_idle_timeout

    params = { "tcp": {"uuid": uuid,
        "tcp-idle-timeout": tcp_idle_timeout,
        "half-open-idle-timeout": half_open_idle_timeout,
        "force-delete-timeout": force_delete_timeout,
        "port-cfg": port_cfg,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "half-close-idle-timeout": half_close_idle_timeout,} }

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
    url = "/axapi/v3/fw/session-aging/%<name>s/tcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end