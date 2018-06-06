resource_name :a10_snmp_server_enable

property :a10_name, String, name_property: true
property :uuid, String
property :service, [true, false]
property :traps, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/"
    get_url = "/axapi/v3/snmp-server/enable"
    uuid = new_resource.uuid
    service = new_resource.service
    traps = new_resource.traps

    params = { "enable": {"uuid": uuid,
        "service": service,
        "traps": traps,} }

    params[:"enable"].each do |k, v|
        if not v 
            params[:"enable"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating enable') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable"
    uuid = new_resource.uuid
    service = new_resource.service
    traps = new_resource.traps

    params = { "enable": {"uuid": uuid,
        "service": service,
        "traps": traps,} }

    params[:"enable"].each do |k, v|
        if not v
            params[:"enable"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["enable"].each do |k, v|
        if v != params[:"enable"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating enable') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting enable') do
            client.delete(url)
        end
    end
end