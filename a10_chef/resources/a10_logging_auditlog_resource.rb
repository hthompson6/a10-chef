resource_name :a10_logging_auditlog

property :a10_name, String, name_property: true
property :audit_facility, ['local0','local1','local2','local3','local4','local5','local6','local7']
property :host6, String
property :host4, String
property :uuid, String
property :port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/auditlog"
    audit_facility = new_resource.audit_facility
    host6 = new_resource.host6
    host4 = new_resource.host4
    uuid = new_resource.uuid
    port = new_resource.port

    params = { "auditlog": {"audit-facility": audit_facility,
        "host6": host6,
        "host4": host4,
        "uuid": uuid,
        "port": port,} }

    params[:"auditlog"].each do |k, v|
        if not v 
            params[:"auditlog"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auditlog') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/auditlog"
    audit_facility = new_resource.audit_facility
    host6 = new_resource.host6
    host4 = new_resource.host4
    uuid = new_resource.uuid
    port = new_resource.port

    params = { "auditlog": {"audit-facility": audit_facility,
        "host6": host6,
        "host4": host4,
        "uuid": uuid,
        "port": port,} }

    params[:"auditlog"].each do |k, v|
        if not v
            params[:"auditlog"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auditlog"].each do |k, v|
        if v != params[:"auditlog"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auditlog') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/auditlog"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auditlog') do
            client.delete(url)
        end
    end
end