resource_name :a10_health_monitor_method_udp

property :a10_name, String, name_property: true
property :udp, [true, false]
property :uuid, String
property :force_up_with_single_healthcheck, [true, false]
property :udp_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/udp"
    udp = new_resource.udp
    uuid = new_resource.uuid
    force_up_with_single_healthcheck = new_resource.force_up_with_single_healthcheck
    udp_port = new_resource.udp_port

    params = { "udp": {"udp": udp,
        "uuid": uuid,
        "force-up-with-single-healthcheck": force_up_with_single_healthcheck,
        "udp-port": udp_port,} }

    params[:"udp"].each do |k, v|
        if not v 
            params[:"udp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating udp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/udp"
    udp = new_resource.udp
    uuid = new_resource.uuid
    force_up_with_single_healthcheck = new_resource.force_up_with_single_healthcheck
    udp_port = new_resource.udp_port

    params = { "udp": {"udp": udp,
        "uuid": uuid,
        "force-up-with-single-healthcheck": force_up_with_single_healthcheck,
        "udp-port": udp_port,} }

    params[:"udp"].each do |k, v|
        if not v
            params[:"udp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["udp"].each do |k, v|
        if v != params[:"udp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating udp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/udp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting udp') do
            client.delete(url)
        end
    end
end