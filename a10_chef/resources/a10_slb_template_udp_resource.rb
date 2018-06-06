resource_name :a10_slb_template_udp

property :a10_name, String, name_property: true
property :short, [true, false]
property :qos, Integer
property :age, Integer
property :stateless_conn_timeout, Integer
property :idle_timeout, Integer
property :re_select_if_server_down, [true, false]
property :immediate, [true, false]
property :user_tag, String
property :disable_clear_session, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/udp/"
    get_url = "/axapi/v3/slb/template/udp/%<name>s"
    short = new_resource.short
    qos = new_resource.qos
    a10_name = new_resource.a10_name
    age = new_resource.age
    stateless_conn_timeout = new_resource.stateless_conn_timeout
    idle_timeout = new_resource.idle_timeout
    re_select_if_server_down = new_resource.re_select_if_server_down
    immediate = new_resource.immediate
    user_tag = new_resource.user_tag
    disable_clear_session = new_resource.disable_clear_session
    uuid = new_resource.uuid

    params = { "udp": {"short": short,
        "qos": qos,
        "name": a10_name,
        "age": age,
        "stateless-conn-timeout": stateless_conn_timeout,
        "idle-timeout": idle_timeout,
        "re-select-if-server-down": re_select_if_server_down,
        "immediate": immediate,
        "user-tag": user_tag,
        "disable-clear-session": disable_clear_session,
        "uuid": uuid,} }

    params[:"udp"].each do |k, v|
        if not v 
            params[:"udp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating udp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/udp/%<name>s"
    short = new_resource.short
    qos = new_resource.qos
    a10_name = new_resource.a10_name
    age = new_resource.age
    stateless_conn_timeout = new_resource.stateless_conn_timeout
    idle_timeout = new_resource.idle_timeout
    re_select_if_server_down = new_resource.re_select_if_server_down
    immediate = new_resource.immediate
    user_tag = new_resource.user_tag
    disable_clear_session = new_resource.disable_clear_session
    uuid = new_resource.uuid

    params = { "udp": {"short": short,
        "qos": qos,
        "name": a10_name,
        "age": age,
        "stateless-conn-timeout": stateless_conn_timeout,
        "idle-timeout": idle_timeout,
        "re-select-if-server-down": re_select_if_server_down,
        "immediate": immediate,
        "user-tag": user_tag,
        "disable-clear-session": disable_clear_session,
        "uuid": uuid,} }

    params[:"udp"].each do |k, v|
        if not v
            params[:"udp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["udp"].each do |k, v|
        if v != params[:"udp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating udp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/udp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting udp') do
            client.delete(url)
        end
    end
end