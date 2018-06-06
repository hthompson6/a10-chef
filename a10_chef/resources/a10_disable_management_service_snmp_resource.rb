resource_name :a10_disable_management_service_snmp

property :a10_name, String, name_property: true
property :management, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/disable-management/service/"
    get_url = "/axapi/v3/disable-management/service/snmp"
    management = new_resource.management
    uuid = new_resource.uuid

    params = { "snmp": {"management": management,
        "uuid": uuid,} }

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
    url = "/axapi/v3/disable-management/service/snmp"
    management = new_resource.management
    uuid = new_resource.uuid

    params = { "snmp": {"management": management,
        "uuid": uuid,} }

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
    url = "/axapi/v3/disable-management/service/snmp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting snmp') do
            client.delete(url)
        end
    end
end