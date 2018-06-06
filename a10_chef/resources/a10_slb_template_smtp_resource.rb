resource_name :a10_slb_template_smtp

property :a10_name, String, name_property: true
property :user_tag, String
property :server_domain, String
property :client_domain_switching, Array
property :client_starttls_type, ['optional','enforced']
property :command_disable, Array
property :server_starttls_type, ['optional','enforced']
property :service_ready_msg, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/smtp/"
    get_url = "/axapi/v3/slb/template/smtp/%<name>s"
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    server_domain = new_resource.server_domain
    client_domain_switching = new_resource.client_domain_switching
    client_starttls_type = new_resource.client_starttls_type
    command_disable = new_resource.command_disable
    server_starttls_type = new_resource.server_starttls_type
    service_ready_msg = new_resource.service_ready_msg
    uuid = new_resource.uuid

    params = { "smtp": {"name": a10_name,
        "user-tag": user_tag,
        "server-domain": server_domain,
        "client-domain-switching": client_domain_switching,
        "client-starttls-type": client_starttls_type,
        "command-disable": command_disable,
        "server-starttls-type": server_starttls_type,
        "service-ready-msg": service_ready_msg,
        "uuid": uuid,} }

    params[:"smtp"].each do |k, v|
        if not v 
            params[:"smtp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating smtp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/smtp/%<name>s"
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    server_domain = new_resource.server_domain
    client_domain_switching = new_resource.client_domain_switching
    client_starttls_type = new_resource.client_starttls_type
    command_disable = new_resource.command_disable
    server_starttls_type = new_resource.server_starttls_type
    service_ready_msg = new_resource.service_ready_msg
    uuid = new_resource.uuid

    params = { "smtp": {"name": a10_name,
        "user-tag": user_tag,
        "server-domain": server_domain,
        "client-domain-switching": client_domain_switching,
        "client-starttls-type": client_starttls_type,
        "command-disable": command_disable,
        "server-starttls-type": server_starttls_type,
        "service-ready-msg": service_ready_msg,
        "uuid": uuid,} }

    params[:"smtp"].each do |k, v|
        if not v
            params[:"smtp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["smtp"].each do |k, v|
        if v != params[:"smtp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating smtp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/smtp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting smtp') do
            client.delete(url)
        end
    end
end