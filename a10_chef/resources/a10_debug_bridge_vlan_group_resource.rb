resource_name :a10_debug_bridge_vlan_group

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/bridge-vlan-group"
    uuid = new_resource.uuid

    params = { "bridge-vlan-group": {"uuid": uuid,} }

    params[:"bridge-vlan-group"].each do |k, v|
        if not v 
            params[:"bridge-vlan-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bridge-vlan-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/bridge-vlan-group"
    uuid = new_resource.uuid

    params = { "bridge-vlan-group": {"uuid": uuid,} }

    params[:"bridge-vlan-group"].each do |k, v|
        if not v
            params[:"bridge-vlan-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bridge-vlan-group"].each do |k, v|
        if v != params[:"bridge-vlan-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bridge-vlan-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/bridge-vlan-group"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bridge-vlan-group') do
            client.delete(url)
        end
    end
end