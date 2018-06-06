resource_name :a10_aam_authentication_server_ocsp_instance

property :a10_name, String, name_property: true
property :health_check_string, String
property :responder_ca, String
property :url, String
property :responder_cert, String
property :health_check_disable, [true, false]
property :sampling_enable, Array
property :port_health_check_disable, [true, false]
property :port_health_check, String
property :health_check, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/ocsp/instance/"
    get_url = "/axapi/v3/aam/authentication/server/ocsp/instance/%<name>s"
    health_check_string = new_resource.health_check_string
    responder_ca = new_resource.responder_ca
    a10_name = new_resource.a10_name
    url = new_resource.url
    responder_cert = new_resource.responder_cert
    health_check_disable = new_resource.health_check_disable
    sampling_enable = new_resource.sampling_enable
    port_health_check_disable = new_resource.port_health_check_disable
    port_health_check = new_resource.port_health_check
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "instance": {"health-check-string": health_check_string,
        "responder-ca": responder_ca,
        "name": a10_name,
        "url": url,
        "responder-cert": responder_cert,
        "health-check-disable": health_check_disable,
        "sampling-enable": sampling_enable,
        "port-health-check-disable": port_health_check_disable,
        "port-health-check": port_health_check,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"instance"].each do |k, v|
        if not v 
            params[:"instance"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating instance') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/ocsp/instance/%<name>s"
    health_check_string = new_resource.health_check_string
    responder_ca = new_resource.responder_ca
    a10_name = new_resource.a10_name
    url = new_resource.url
    responder_cert = new_resource.responder_cert
    health_check_disable = new_resource.health_check_disable
    sampling_enable = new_resource.sampling_enable
    port_health_check_disable = new_resource.port_health_check_disable
    port_health_check = new_resource.port_health_check
    health_check = new_resource.health_check
    uuid = new_resource.uuid

    params = { "instance": {"health-check-string": health_check_string,
        "responder-ca": responder_ca,
        "name": a10_name,
        "url": url,
        "responder-cert": responder_cert,
        "health-check-disable": health_check_disable,
        "sampling-enable": sampling_enable,
        "port-health-check-disable": port_health_check_disable,
        "port-health-check": port_health_check,
        "health-check": health_check,
        "uuid": uuid,} }

    params[:"instance"].each do |k, v|
        if not v
            params[:"instance"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["instance"].each do |k, v|
        if v != params[:"instance"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating instance') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/ocsp/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end