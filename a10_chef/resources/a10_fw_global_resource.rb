resource_name :a10_fw_global

property :a10_name, String, name_property: true
property :alg_processing, ['honor-rule-set','override-rule-set']
property :uuid, String
property :listen_on_port_timeout, Integer
property :disable_ip_fw_sessions, [true, false]
property :sampling_enable, Array
property :permit_default_action, ['forward','next-service-mode']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/global"
    alg_processing = new_resource.alg_processing
    uuid = new_resource.uuid
    listen_on_port_timeout = new_resource.listen_on_port_timeout
    disable_ip_fw_sessions = new_resource.disable_ip_fw_sessions
    sampling_enable = new_resource.sampling_enable
    permit_default_action = new_resource.permit_default_action

    params = { "global": {"alg-processing": alg_processing,
        "uuid": uuid,
        "listen-on-port-timeout": listen_on_port_timeout,
        "disable-ip-fw-sessions": disable_ip_fw_sessions,
        "sampling-enable": sampling_enable,
        "permit-default-action": permit_default_action,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/global"
    alg_processing = new_resource.alg_processing
    uuid = new_resource.uuid
    listen_on_port_timeout = new_resource.listen_on_port_timeout
    disable_ip_fw_sessions = new_resource.disable_ip_fw_sessions
    sampling_enable = new_resource.sampling_enable
    permit_default_action = new_resource.permit_default_action

    params = { "global": {"alg-processing": alg_processing,
        "uuid": uuid,
        "listen-on-port-timeout": listen_on_port_timeout,
        "disable-ip-fw-sessions": disable_ip_fw_sessions,
        "sampling-enable": sampling_enable,
        "permit-default-action": permit_default_action,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end