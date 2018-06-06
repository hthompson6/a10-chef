resource_name :a10_ip_nat_template_logging

property :a10_name, String, name_property: true
property :uuid, String
property :facility, ['kernel','user','mail','daemon','security-authorization','syslog','line-printer','news','uucp','cron','security-authorization-private','ftp','ntp','audit','alert','clock','local0','local1','local2','local3','local4','local5','local6','local7']
property :include_destination, [true, false]
property :user_tag, String
property :service_group, String
property :log, Hash
property :source_port, Hash
property :include_rip_rport, [true, false]
property :severity, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/template/logging/"
    get_url = "/axapi/v3/ip/nat/template/logging/%<name>s"
    uuid = new_resource.uuid
    facility = new_resource.facility
    include_destination = new_resource.include_destination
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    service_group = new_resource.service_group
    log = new_resource.log
    source_port = new_resource.source_port
    include_rip_rport = new_resource.include_rip_rport
    severity = new_resource.severity

    params = { "logging": {"uuid": uuid,
        "facility": facility,
        "include-destination": include_destination,
        "user-tag": user_tag,
        "name": a10_name,
        "service-group": service_group,
        "log": log,
        "source-port": source_port,
        "include-rip-rport": include_rip_rport,
        "severity": severity,} }

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
    url = "/axapi/v3/ip/nat/template/logging/%<name>s"
    uuid = new_resource.uuid
    facility = new_resource.facility
    include_destination = new_resource.include_destination
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    service_group = new_resource.service_group
    log = new_resource.log
    source_port = new_resource.source_port
    include_rip_rport = new_resource.include_rip_rport
    severity = new_resource.severity

    params = { "logging": {"uuid": uuid,
        "facility": facility,
        "include-destination": include_destination,
        "user-tag": user_tag,
        "name": a10_name,
        "service-group": service_group,
        "log": log,
        "source-port": source_port,
        "include-rip-rport": include_rip_rport,
        "severity": severity,} }

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
    url = "/axapi/v3/ip/nat/template/logging/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logging') do
            client.delete(url)
        end
    end
end