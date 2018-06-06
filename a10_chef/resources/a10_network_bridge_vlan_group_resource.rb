resource_name :a10_network_bridge_vlan_group

property :a10_name, String, name_property: true
property :vlan_list, Array
property :ve, Integer
property :forward_traffic, ['forward-all-traffic','forward-ip-traffic']
property :uuid, String
property :user_tag, String
property :bridge_vlan_group_number, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/bridge-vlan-group/"
    get_url = "/axapi/v3/network/bridge-vlan-group/%<bridge-vlan-group-number>s"
    vlan_list = new_resource.vlan_list
    ve = new_resource.ve
    forward_traffic = new_resource.forward_traffic
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    bridge_vlan_group_number = new_resource.bridge_vlan_group_number
    a10_name = new_resource.a10_name

    params = { "bridge-vlan-group": {"vlan-list": vlan_list,
        "ve": ve,
        "forward-traffic": forward_traffic,
        "uuid": uuid,
        "user-tag": user_tag,
        "bridge-vlan-group-number": bridge_vlan_group_number,
        "name": a10_name,} }

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
    url = "/axapi/v3/network/bridge-vlan-group/%<bridge-vlan-group-number>s"
    vlan_list = new_resource.vlan_list
    ve = new_resource.ve
    forward_traffic = new_resource.forward_traffic
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    bridge_vlan_group_number = new_resource.bridge_vlan_group_number
    a10_name = new_resource.a10_name

    params = { "bridge-vlan-group": {"vlan-list": vlan_list,
        "ve": ve,
        "forward-traffic": forward_traffic,
        "uuid": uuid,
        "user-tag": user_tag,
        "bridge-vlan-group-number": bridge_vlan_group_number,
        "name": a10_name,} }

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
    url = "/axapi/v3/network/bridge-vlan-group/%<bridge-vlan-group-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bridge-vlan-group') do
            client.delete(url)
        end
    end
end