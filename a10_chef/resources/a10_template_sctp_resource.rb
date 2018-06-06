resource_name :a10_template_sctp

property :a10_name, String, name_property: true
property :checksum_check, ['enable']
property :log, Hash
property :permit_payload_protocol, Hash
property :user_tag, String
property :sctp_idle_timeout, Integer
property :sctp_half_open_idle_timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/template/sctp/"
    get_url = "/axapi/v3/template/sctp/%<name>s"
    checksum_check = new_resource.checksum_check
    log = new_resource.log
    permit_payload_protocol = new_resource.permit_payload_protocol
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    sctp_idle_timeout = new_resource.sctp_idle_timeout
    sctp_half_open_idle_timeout = new_resource.sctp_half_open_idle_timeout
    uuid = new_resource.uuid

    params = { "sctp": {"checksum-check": checksum_check,
        "log": log,
        "permit-payload-protocol": permit_payload_protocol,
        "user-tag": user_tag,
        "name": a10_name,
        "sctp-idle-timeout": sctp_idle_timeout,
        "sctp-half-open-idle-timeout": sctp_half_open_idle_timeout,
        "uuid": uuid,} }

    params[:"sctp"].each do |k, v|
        if not v 
            params[:"sctp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sctp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/sctp/%<name>s"
    checksum_check = new_resource.checksum_check
    log = new_resource.log
    permit_payload_protocol = new_resource.permit_payload_protocol
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    sctp_idle_timeout = new_resource.sctp_idle_timeout
    sctp_half_open_idle_timeout = new_resource.sctp_half_open_idle_timeout
    uuid = new_resource.uuid

    params = { "sctp": {"checksum-check": checksum_check,
        "log": log,
        "permit-payload-protocol": permit_payload_protocol,
        "user-tag": user_tag,
        "name": a10_name,
        "sctp-idle-timeout": sctp_idle_timeout,
        "sctp-half-open-idle-timeout": sctp_half_open_idle_timeout,
        "uuid": uuid,} }

    params[:"sctp"].each do |k, v|
        if not v
            params[:"sctp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sctp"].each do |k, v|
        if v != params[:"sctp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sctp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/sctp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sctp') do
            client.delete(url)
        end
    end
end