resource_name :a10_health_monitor_method_ntp

property :a10_name, String, name_property: true
property :ntp, [true, false]
property :uuid, String
property :ntp_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/ntp"
    ntp = new_resource.ntp
    uuid = new_resource.uuid
    ntp_port = new_resource.ntp_port

    params = { "ntp": {"ntp": ntp,
        "uuid": uuid,
        "ntp-port": ntp_port,} }

    params[:"ntp"].each do |k, v|
        if not v 
            params[:"ntp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ntp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ntp"
    ntp = new_resource.ntp
    uuid = new_resource.uuid
    ntp_port = new_resource.ntp_port

    params = { "ntp": {"ntp": ntp,
        "uuid": uuid,
        "ntp-port": ntp_port,} }

    params[:"ntp"].each do |k, v|
        if not v
            params[:"ntp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ntp"].each do |k, v|
        if v != params[:"ntp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ntp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/ntp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ntp') do
            client.delete(url)
        end
    end
end