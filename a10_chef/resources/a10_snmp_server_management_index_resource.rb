resource_name :a10_snmp_server_management_index

property :a10_name, String, name_property: true
property :mgmt_index, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/"
    get_url = "/axapi/v3/snmp-server/management-index"
    mgmt_index = new_resource.mgmt_index
    uuid = new_resource.uuid

    params = { "management-index": {"mgmt-index": mgmt_index,
        "uuid": uuid,} }

    params[:"management-index"].each do |k, v|
        if not v 
            params[:"management-index"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating management-index') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/management-index"
    mgmt_index = new_resource.mgmt_index
    uuid = new_resource.uuid

    params = { "management-index": {"mgmt-index": mgmt_index,
        "uuid": uuid,} }

    params[:"management-index"].each do |k, v|
        if not v
            params[:"management-index"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["management-index"].each do |k, v|
        if v != params[:"management-index"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating management-index') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/management-index"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting management-index') do
            client.delete(url)
        end
    end
end