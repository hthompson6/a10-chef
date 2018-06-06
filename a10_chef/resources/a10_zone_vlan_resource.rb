resource_name :a10_zone_vlan

property :a10_name, String, name_property: true
property :vlan_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/zone/%<name>s/"
    get_url = "/axapi/v3/zone/%<name>s/vlan"
    vlan_list = new_resource.vlan_list
    uuid = new_resource.uuid

    params = { "vlan": {"vlan-list": vlan_list,
        "uuid": uuid,} }

    params[:"vlan"].each do |k, v|
        if not v 
            params[:"vlan"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vlan') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/vlan"
    vlan_list = new_resource.vlan_list
    uuid = new_resource.uuid

    params = { "vlan": {"vlan-list": vlan_list,
        "uuid": uuid,} }

    params[:"vlan"].each do |k, v|
        if not v
            params[:"vlan"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vlan"].each do |k, v|
        if v != params[:"vlan"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vlan') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/vlan"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vlan') do
            client.delete(url)
        end
    end
end