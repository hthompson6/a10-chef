resource_name :a10_slb_template_diameter

property :a10_name, String, name_property: true
property :avp_string, String
property :terminate_on_cca_t, [true, false]
property :message_code_list, Array
property :avp_list, Array
property :service_group_name, String
property :uuid, String
property :idle_timeout, Integer
property :customize_cea, [true, false]
property :product_name, String
property :dwr_up_retry, Integer
property :forward_unknown_session_id, [true, false]
property :avp_code, Integer
property :vendor_id, Integer
property :session_age, Integer
property :load_balance_on_session_id, [true, false]
property :dwr_time, Integer
property :user_tag, String
property :origin_realm, String
property :origin_host, Hash
property :multiple_origin_host, [true, false]
property :forward_to_latest_server, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/diameter/"
    get_url = "/axapi/v3/slb/template/diameter/%<name>s"
    avp_string = new_resource.avp_string
    terminate_on_cca_t = new_resource.terminate_on_cca_t
    message_code_list = new_resource.message_code_list
    avp_list = new_resource.avp_list
    service_group_name = new_resource.service_group_name
    uuid = new_resource.uuid
    idle_timeout = new_resource.idle_timeout
    customize_cea = new_resource.customize_cea
    product_name = new_resource.product_name
    dwr_up_retry = new_resource.dwr_up_retry
    forward_unknown_session_id = new_resource.forward_unknown_session_id
    avp_code = new_resource.avp_code
    vendor_id = new_resource.vendor_id
    session_age = new_resource.session_age
    load_balance_on_session_id = new_resource.load_balance_on_session_id
    a10_name = new_resource.a10_name
    dwr_time = new_resource.dwr_time
    user_tag = new_resource.user_tag
    origin_realm = new_resource.origin_realm
    origin_host = new_resource.origin_host
    multiple_origin_host = new_resource.multiple_origin_host
    forward_to_latest_server = new_resource.forward_to_latest_server

    params = { "diameter": {"avp-string": avp_string,
        "terminate-on-cca-t": terminate_on_cca_t,
        "message-code-list": message_code_list,
        "avp-list": avp_list,
        "service-group-name": service_group_name,
        "uuid": uuid,
        "idle-timeout": idle_timeout,
        "customize-cea": customize_cea,
        "product-name": product_name,
        "dwr-up-retry": dwr_up_retry,
        "forward-unknown-session-id": forward_unknown_session_id,
        "avp-code": avp_code,
        "vendor-id": vendor_id,
        "session-age": session_age,
        "load-balance-on-session-id": load_balance_on_session_id,
        "name": a10_name,
        "dwr-time": dwr_time,
        "user-tag": user_tag,
        "origin-realm": origin_realm,
        "origin-host": origin_host,
        "multiple-origin-host": multiple_origin_host,
        "forward-to-latest-server": forward_to_latest_server,} }

    params[:"diameter"].each do |k, v|
        if not v 
            params[:"diameter"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating diameter') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/diameter/%<name>s"
    avp_string = new_resource.avp_string
    terminate_on_cca_t = new_resource.terminate_on_cca_t
    message_code_list = new_resource.message_code_list
    avp_list = new_resource.avp_list
    service_group_name = new_resource.service_group_name
    uuid = new_resource.uuid
    idle_timeout = new_resource.idle_timeout
    customize_cea = new_resource.customize_cea
    product_name = new_resource.product_name
    dwr_up_retry = new_resource.dwr_up_retry
    forward_unknown_session_id = new_resource.forward_unknown_session_id
    avp_code = new_resource.avp_code
    vendor_id = new_resource.vendor_id
    session_age = new_resource.session_age
    load_balance_on_session_id = new_resource.load_balance_on_session_id
    a10_name = new_resource.a10_name
    dwr_time = new_resource.dwr_time
    user_tag = new_resource.user_tag
    origin_realm = new_resource.origin_realm
    origin_host = new_resource.origin_host
    multiple_origin_host = new_resource.multiple_origin_host
    forward_to_latest_server = new_resource.forward_to_latest_server

    params = { "diameter": {"avp-string": avp_string,
        "terminate-on-cca-t": terminate_on_cca_t,
        "message-code-list": message_code_list,
        "avp-list": avp_list,
        "service-group-name": service_group_name,
        "uuid": uuid,
        "idle-timeout": idle_timeout,
        "customize-cea": customize_cea,
        "product-name": product_name,
        "dwr-up-retry": dwr_up_retry,
        "forward-unknown-session-id": forward_unknown_session_id,
        "avp-code": avp_code,
        "vendor-id": vendor_id,
        "session-age": session_age,
        "load-balance-on-session-id": load_balance_on_session_id,
        "name": a10_name,
        "dwr-time": dwr_time,
        "user-tag": user_tag,
        "origin-realm": origin_realm,
        "origin-host": origin_host,
        "multiple-origin-host": multiple_origin_host,
        "forward-to-latest-server": forward_to_latest_server,} }

    params[:"diameter"].each do |k, v|
        if not v
            params[:"diameter"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["diameter"].each do |k, v|
        if v != params[:"diameter"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating diameter') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/diameter/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting diameter') do
            client.delete(url)
        end
    end
end