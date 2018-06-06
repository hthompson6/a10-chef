resource_name :a10_template_gtp

property :a10_name, String, name_property: true
property :mandatory_ie_filtering, ['disable']
property :gtp_v2, Array
property :user_tag, String
property :log, Hash
property :tunnel_timeout, Integer
property :gtp_filter_list, String
property :maximum_message_length, Integer
property :protocol_anomaly_filtering, ['disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/template/gtp/"
    get_url = "/axapi/v3/template/gtp/%<name>s"
    mandatory_ie_filtering = new_resource.mandatory_ie_filtering
    a10_name = new_resource.a10_name
    gtp_v2 = new_resource.gtp_v2
    user_tag = new_resource.user_tag
    log = new_resource.log
    tunnel_timeout = new_resource.tunnel_timeout
    gtp_filter_list = new_resource.gtp_filter_list
    maximum_message_length = new_resource.maximum_message_length
    protocol_anomaly_filtering = new_resource.protocol_anomaly_filtering
    uuid = new_resource.uuid

    params = { "gtp": {"mandatory-ie-filtering": mandatory_ie_filtering,
        "name": a10_name,
        "gtp-v2": gtp_v2,
        "user-tag": user_tag,
        "log": log,
        "tunnel-timeout": tunnel_timeout,
        "gtp-filter-list": gtp_filter_list,
        "maximum-message-length": maximum_message_length,
        "protocol-anomaly-filtering": protocol_anomaly_filtering,
        "uuid": uuid,} }

    params[:"gtp"].each do |k, v|
        if not v 
            params[:"gtp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating gtp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/gtp/%<name>s"
    mandatory_ie_filtering = new_resource.mandatory_ie_filtering
    a10_name = new_resource.a10_name
    gtp_v2 = new_resource.gtp_v2
    user_tag = new_resource.user_tag
    log = new_resource.log
    tunnel_timeout = new_resource.tunnel_timeout
    gtp_filter_list = new_resource.gtp_filter_list
    maximum_message_length = new_resource.maximum_message_length
    protocol_anomaly_filtering = new_resource.protocol_anomaly_filtering
    uuid = new_resource.uuid

    params = { "gtp": {"mandatory-ie-filtering": mandatory_ie_filtering,
        "name": a10_name,
        "gtp-v2": gtp_v2,
        "user-tag": user_tag,
        "log": log,
        "tunnel-timeout": tunnel_timeout,
        "gtp-filter-list": gtp_filter_list,
        "maximum-message-length": maximum_message_length,
        "protocol-anomaly-filtering": protocol_anomaly_filtering,
        "uuid": uuid,} }

    params[:"gtp"].each do |k, v|
        if not v
            params[:"gtp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["gtp"].each do |k, v|
        if v != params[:"gtp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating gtp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/gtp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting gtp') do
            client.delete(url)
        end
    end
end