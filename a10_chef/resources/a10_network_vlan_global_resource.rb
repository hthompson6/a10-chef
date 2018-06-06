resource_name :a10_network_vlan_global

property :a10_name, String, name_property: true
property :l3_vlan_fwd_disable, [true, false]
property :uuid, String
property :enable_def_vlan_l2_forwarding, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/vlan-global"
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    uuid = new_resource.uuid
    enable_def_vlan_l2_forwarding = new_resource.enable_def_vlan_l2_forwarding

    params = { "vlan-global": {"l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "uuid": uuid,
        "enable-def-vlan-l2-forwarding": enable_def_vlan_l2_forwarding,} }

    params[:"vlan-global"].each do |k, v|
        if not v 
            params[:"vlan-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vlan-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/vlan-global"
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    uuid = new_resource.uuid
    enable_def_vlan_l2_forwarding = new_resource.enable_def_vlan_l2_forwarding

    params = { "vlan-global": {"l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "uuid": uuid,
        "enable-def-vlan-l2-forwarding": enable_def_vlan_l2_forwarding,} }

    params[:"vlan-global"].each do |k, v|
        if not v
            params[:"vlan-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vlan-global"].each do |k, v|
        if v != params[:"vlan-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vlan-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/vlan-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vlan-global') do
            client.delete(url)
        end
    end
end