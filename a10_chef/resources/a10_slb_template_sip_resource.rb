resource_name :a10_slb_template_sip

property :a10_name, String, name_property: true
property :server_request_header, Array
property :smp_call_id_rtp_session, [true, false]
property :keep_server_ip_if_match_acl, [true, false]
property :client_keep_alive, [true, false]
property :alg_source_nat, [true, false]
property :uuid, String
property :server_response_header, Array
property :server_selection_per_request, [true, false]
property :client_request_header, Array
property :pstn_gw, String
property :service_group, String
property :insert_client_ip, [true, false]
property :failed_client_selection, [true, false]
property :failed_client_selection_message, String
property :call_id_persist_disable, [true, false]
property :acl_id, Integer
property :alg_dest_nat, [true, false]
property :server_keep_alive, [true, false]
property :client_response_header, Array
property :failed_server_selection_message, String
property :exclude_translation, Array
property :interval, Integer
property :user_tag, String
property :dialog_aware, [true, false]
property :failed_server_selection, [true, false]
property :drop_when_client_fail, [true, false]
property :timeout, Integer
property :drop_when_server_fail, [true, false]
property :acl_name_value, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/sip/"
    get_url = "/axapi/v3/slb/template/sip/%<name>s"
    server_request_header = new_resource.server_request_header
    smp_call_id_rtp_session = new_resource.smp_call_id_rtp_session
    keep_server_ip_if_match_acl = new_resource.keep_server_ip_if_match_acl
    client_keep_alive = new_resource.client_keep_alive
    alg_source_nat = new_resource.alg_source_nat
    uuid = new_resource.uuid
    server_response_header = new_resource.server_response_header
    server_selection_per_request = new_resource.server_selection_per_request
    client_request_header = new_resource.client_request_header
    pstn_gw = new_resource.pstn_gw
    service_group = new_resource.service_group
    insert_client_ip = new_resource.insert_client_ip
    failed_client_selection = new_resource.failed_client_selection
    failed_client_selection_message = new_resource.failed_client_selection_message
    call_id_persist_disable = new_resource.call_id_persist_disable
    acl_id = new_resource.acl_id
    alg_dest_nat = new_resource.alg_dest_nat
    server_keep_alive = new_resource.server_keep_alive
    client_response_header = new_resource.client_response_header
    failed_server_selection_message = new_resource.failed_server_selection_message
    a10_name = new_resource.a10_name
    exclude_translation = new_resource.exclude_translation
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    dialog_aware = new_resource.dialog_aware
    failed_server_selection = new_resource.failed_server_selection
    drop_when_client_fail = new_resource.drop_when_client_fail
    timeout = new_resource.timeout
    drop_when_server_fail = new_resource.drop_when_server_fail
    acl_name_value = new_resource.acl_name_value

    params = { "sip": {"server-request-header": server_request_header,
        "smp-call-id-rtp-session": smp_call_id_rtp_session,
        "keep-server-ip-if-match-acl": keep_server_ip_if_match_acl,
        "client-keep-alive": client_keep_alive,
        "alg-source-nat": alg_source_nat,
        "uuid": uuid,
        "server-response-header": server_response_header,
        "server-selection-per-request": server_selection_per_request,
        "client-request-header": client_request_header,
        "pstn-gw": pstn_gw,
        "service-group": service_group,
        "insert-client-ip": insert_client_ip,
        "failed-client-selection": failed_client_selection,
        "failed-client-selection-message": failed_client_selection_message,
        "call-id-persist-disable": call_id_persist_disable,
        "acl-id": acl_id,
        "alg-dest-nat": alg_dest_nat,
        "server-keep-alive": server_keep_alive,
        "client-response-header": client_response_header,
        "failed-server-selection-message": failed_server_selection_message,
        "name": a10_name,
        "exclude-translation": exclude_translation,
        "interval": interval,
        "user-tag": user_tag,
        "dialog-aware": dialog_aware,
        "failed-server-selection": failed_server_selection,
        "drop-when-client-fail": drop_when_client_fail,
        "timeout": timeout,
        "drop-when-server-fail": drop_when_server_fail,
        "acl-name-value": acl_name_value,} }

    params[:"sip"].each do |k, v|
        if not v 
            params[:"sip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/sip/%<name>s"
    server_request_header = new_resource.server_request_header
    smp_call_id_rtp_session = new_resource.smp_call_id_rtp_session
    keep_server_ip_if_match_acl = new_resource.keep_server_ip_if_match_acl
    client_keep_alive = new_resource.client_keep_alive
    alg_source_nat = new_resource.alg_source_nat
    uuid = new_resource.uuid
    server_response_header = new_resource.server_response_header
    server_selection_per_request = new_resource.server_selection_per_request
    client_request_header = new_resource.client_request_header
    pstn_gw = new_resource.pstn_gw
    service_group = new_resource.service_group
    insert_client_ip = new_resource.insert_client_ip
    failed_client_selection = new_resource.failed_client_selection
    failed_client_selection_message = new_resource.failed_client_selection_message
    call_id_persist_disable = new_resource.call_id_persist_disable
    acl_id = new_resource.acl_id
    alg_dest_nat = new_resource.alg_dest_nat
    server_keep_alive = new_resource.server_keep_alive
    client_response_header = new_resource.client_response_header
    failed_server_selection_message = new_resource.failed_server_selection_message
    a10_name = new_resource.a10_name
    exclude_translation = new_resource.exclude_translation
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    dialog_aware = new_resource.dialog_aware
    failed_server_selection = new_resource.failed_server_selection
    drop_when_client_fail = new_resource.drop_when_client_fail
    timeout = new_resource.timeout
    drop_when_server_fail = new_resource.drop_when_server_fail
    acl_name_value = new_resource.acl_name_value

    params = { "sip": {"server-request-header": server_request_header,
        "smp-call-id-rtp-session": smp_call_id_rtp_session,
        "keep-server-ip-if-match-acl": keep_server_ip_if_match_acl,
        "client-keep-alive": client_keep_alive,
        "alg-source-nat": alg_source_nat,
        "uuid": uuid,
        "server-response-header": server_response_header,
        "server-selection-per-request": server_selection_per_request,
        "client-request-header": client_request_header,
        "pstn-gw": pstn_gw,
        "service-group": service_group,
        "insert-client-ip": insert_client_ip,
        "failed-client-selection": failed_client_selection,
        "failed-client-selection-message": failed_client_selection_message,
        "call-id-persist-disable": call_id_persist_disable,
        "acl-id": acl_id,
        "alg-dest-nat": alg_dest_nat,
        "server-keep-alive": server_keep_alive,
        "client-response-header": client_response_header,
        "failed-server-selection-message": failed_server_selection_message,
        "name": a10_name,
        "exclude-translation": exclude_translation,
        "interval": interval,
        "user-tag": user_tag,
        "dialog-aware": dialog_aware,
        "failed-server-selection": failed_server_selection,
        "drop-when-client-fail": drop_when_client_fail,
        "timeout": timeout,
        "drop-when-server-fail": drop_when_server_fail,
        "acl-name-value": acl_name_value,} }

    params[:"sip"].each do |k, v|
        if not v
            params[:"sip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sip"].each do |k, v|
        if v != params[:"sip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/sip/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sip') do
            client.delete(url)
        end
    end
end