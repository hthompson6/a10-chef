resource_name :a10_cgnv6_template_logging

property :a10_name, String, name_property: true
property :include_inside_user_mac, [true, false]
property :facility, ['kernel','user','mail','daemon','security-authorization','syslog','line-printer','news','uucp','cron','security-authorization-private','ftp','ntp','audit','alert','clock','local0','local1','local2','local3','local4','local5','local6','local7']
property :rule, Hash
property :include_partition_name, [true, false]
property :severity, Hash
property :custom, Hash
property :service_group, String
property :shared, [true, false]
property :include_session_byte_count, [true, false]
property :format, ['binary','compact','custom','default','rfc5424','cef']
property :source_address, Hash
property :log, Hash
property :source_port, Hash
property :uuid, String
property :batched_logging_disable, [true, false]
property :log_receiver, Hash
property :include_destination, [true, false]
property :include_radius_attribute, Hash
property :user_tag, String
property :disable_log_by_destination, Hash
property :rfc_custom, Hash
property :resolution, ['seconds','10-milliseconds']
property :include_http, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/logging/"
    get_url = "/axapi/v3/cgnv6/template/logging/%<name>s"
    include_inside_user_mac = new_resource.include_inside_user_mac
    facility = new_resource.facility
    rule = new_resource.rule
    include_partition_name = new_resource.include_partition_name
    severity = new_resource.severity
    custom = new_resource.custom
    service_group = new_resource.service_group
    shared = new_resource.shared
    include_session_byte_count = new_resource.include_session_byte_count
    format = new_resource.format
    source_address = new_resource.source_address
    log = new_resource.log
    source_port = new_resource.source_port
    uuid = new_resource.uuid
    batched_logging_disable = new_resource.batched_logging_disable
    log_receiver = new_resource.log_receiver
    a10_name = new_resource.a10_name
    include_destination = new_resource.include_destination
    include_radius_attribute = new_resource.include_radius_attribute
    user_tag = new_resource.user_tag
    disable_log_by_destination = new_resource.disable_log_by_destination
    rfc_custom = new_resource.rfc_custom
    resolution = new_resource.resolution
    include_http = new_resource.include_http

    params = { "logging": {"include-inside-user-mac": include_inside_user_mac,
        "facility": facility,
        "rule": rule,
        "include-partition-name": include_partition_name,
        "severity": severity,
        "custom": custom,
        "service-group": service_group,
        "shared": shared,
        "include-session-byte-count": include_session_byte_count,
        "format": format,
        "source-address": source_address,
        "log": log,
        "source-port": source_port,
        "uuid": uuid,
        "batched-logging-disable": batched_logging_disable,
        "log-receiver": log_receiver,
        "name": a10_name,
        "include-destination": include_destination,
        "include-radius-attribute": include_radius_attribute,
        "user-tag": user_tag,
        "disable-log-by-destination": disable_log_by_destination,
        "rfc-custom": rfc_custom,
        "resolution": resolution,
        "include-http": include_http,} }

    params[:"logging"].each do |k, v|
        if not v 
            params[:"logging"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating logging') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/logging/%<name>s"
    include_inside_user_mac = new_resource.include_inside_user_mac
    facility = new_resource.facility
    rule = new_resource.rule
    include_partition_name = new_resource.include_partition_name
    severity = new_resource.severity
    custom = new_resource.custom
    service_group = new_resource.service_group
    shared = new_resource.shared
    include_session_byte_count = new_resource.include_session_byte_count
    format = new_resource.format
    source_address = new_resource.source_address
    log = new_resource.log
    source_port = new_resource.source_port
    uuid = new_resource.uuid
    batched_logging_disable = new_resource.batched_logging_disable
    log_receiver = new_resource.log_receiver
    a10_name = new_resource.a10_name
    include_destination = new_resource.include_destination
    include_radius_attribute = new_resource.include_radius_attribute
    user_tag = new_resource.user_tag
    disable_log_by_destination = new_resource.disable_log_by_destination
    rfc_custom = new_resource.rfc_custom
    resolution = new_resource.resolution
    include_http = new_resource.include_http

    params = { "logging": {"include-inside-user-mac": include_inside_user_mac,
        "facility": facility,
        "rule": rule,
        "include-partition-name": include_partition_name,
        "severity": severity,
        "custom": custom,
        "service-group": service_group,
        "shared": shared,
        "include-session-byte-count": include_session_byte_count,
        "format": format,
        "source-address": source_address,
        "log": log,
        "source-port": source_port,
        "uuid": uuid,
        "batched-logging-disable": batched_logging_disable,
        "log-receiver": log_receiver,
        "name": a10_name,
        "include-destination": include_destination,
        "include-radius-attribute": include_radius_attribute,
        "user-tag": user_tag,
        "disable-log-by-destination": disable_log_by_destination,
        "rfc-custom": rfc_custom,
        "resolution": resolution,
        "include-http": include_http,} }

    params[:"logging"].each do |k, v|
        if not v
            params[:"logging"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["logging"].each do |k, v|
        if v != params[:"logging"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating logging') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/logging/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logging') do
            client.delete(url)
        end
    end
end