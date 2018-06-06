resource_name :a10_snmp_server_location

property :a10_name, String, name_property: true
property :loc, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/"
    get_url = "/axapi/v3/snmp-server/location"
    loc = new_resource.loc
    uuid = new_resource.uuid

    params = { "location": {"loc": loc,
        "uuid": uuid,} }

    params[:"location"].each do |k, v|
        if not v 
            params[:"location"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating location') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/location"
    loc = new_resource.loc
    uuid = new_resource.uuid

    params = { "location": {"loc": loc,
        "uuid": uuid,} }

    params[:"location"].each do |k, v|
        if not v
            params[:"location"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["location"].each do |k, v|
        if v != params[:"location"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating location') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/location"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting location') do
            client.delete(url)
        end
    end
end