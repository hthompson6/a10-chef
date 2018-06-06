resource_name :a10_debug_snmp

property :a10_name, String, name_property: true
property :all, [true, false]
property :error, [true, false]
property :uuid, String
property :event, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/snmp"
    all = new_resource.all
    error = new_resource.error
    uuid = new_resource.uuid
    event = new_resource.event

    params = { "snmp": {"all": all,
        "error": error,
        "uuid": uuid,
        "event": event,} }

    params[:"snmp"].each do |k, v|
        if not v 
            params[:"snmp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating snmp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/snmp"
    all = new_resource.all
    error = new_resource.error
    uuid = new_resource.uuid
    event = new_resource.event

    params = { "snmp": {"all": all,
        "error": error,
        "uuid": uuid,
        "event": event,} }

    params[:"snmp"].each do |k, v|
        if not v
            params[:"snmp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["snmp"].each do |k, v|
        if v != params[:"snmp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating snmp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/snmp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting snmp') do
            client.delete(url)
        end
    end
end