resource_name :a10_fw_template_logging

property :a10_name, String, name_property: true
property :include_http, Hash
property :severity, ['emergency','alert','critical','error','warning','notice','informational','debug']
property :source_address, Hash
property :format, ['ascii','cef']
property :log, Hash
property :facility, ['kernel','user','mail','daemon','security-authorization','syslog','line-printer','news','uucp','cron','security-authorization-private','ftp','ntp','audit','alert','clock','local0','local1','local2','local3','local4','local5','local6','local7']
property :include_radius_attribute, Hash
property :uuid, String
property :rule, Hash
property :service_group, String
property :user_tag, String
property :resolution, ['seconds','10-milliseconds']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/template/logging/"
    get_url = "/axapi/v3/fw/template/logging/%<name>s"
    include_http = new_resource.include_http
    severity = new_resource.severity
    source_address = new_resource.source_address
    format = new_resource.format
    log = new_resource.log
    facility = new_resource.facility
    include_radius_attribute = new_resource.include_radius_attribute
    uuid = new_resource.uuid
    rule = new_resource.rule
    service_group = new_resource.service_group
    user_tag = new_resource.user_tag
    resolution = new_resource.resolution
    a10_name = new_resource.a10_name

    params = { "logging": {"include-http": include_http,
        "severity": severity,
        "source-address": source_address,
        "format": format,
        "log": log,
        "facility": facility,
        "include-radius-attribute": include_radius_attribute,
        "uuid": uuid,
        "rule": rule,
        "service-group": service_group,
        "user-tag": user_tag,
        "resolution": resolution,
        "name": a10_name,} }

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
    url = "/axapi/v3/fw/template/logging/%<name>s"
    include_http = new_resource.include_http
    severity = new_resource.severity
    source_address = new_resource.source_address
    format = new_resource.format
    log = new_resource.log
    facility = new_resource.facility
    include_radius_attribute = new_resource.include_radius_attribute
    uuid = new_resource.uuid
    rule = new_resource.rule
    service_group = new_resource.service_group
    user_tag = new_resource.user_tag
    resolution = new_resource.resolution
    a10_name = new_resource.a10_name

    params = { "logging": {"include-http": include_http,
        "severity": severity,
        "source-address": source_address,
        "format": format,
        "log": log,
        "facility": facility,
        "include-radius-attribute": include_radius_attribute,
        "uuid": uuid,
        "rule": rule,
        "service-group": service_group,
        "user-tag": user_tag,
        "resolution": resolution,
        "name": a10_name,} }

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
    url = "/axapi/v3/fw/template/logging/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logging') do
            client.delete(url)
        end
    end
end