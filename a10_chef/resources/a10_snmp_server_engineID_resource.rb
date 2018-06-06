resource_name :a10_snmp_server_engineID

property :a10_name, String, name_property: true
property :uuid, String
property :engId, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/"
    get_url = "/axapi/v3/snmp-server/engineID"
    uuid = new_resource.uuid
    engId = new_resource.engId

    params = { "engineID": {"uuid": uuid,
        "engId": engId,} }

    params[:"engineID"].each do |k, v|
        if not v 
            params[:"engineID"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating engineID') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/engineID"
    uuid = new_resource.uuid
    engId = new_resource.engId

    params = { "engineID": {"uuid": uuid,
        "engId": engId,} }

    params[:"engineID"].each do |k, v|
        if not v
            params[:"engineID"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["engineID"].each do |k, v|
        if v != params[:"engineID"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating engineID') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/engineID"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting engineID') do
            client.delete(url)
        end
    end
end