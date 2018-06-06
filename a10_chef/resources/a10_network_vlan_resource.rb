resource_name :a10_network_vlan

property :a10_name, String, name_property: true
property :traffic_distribution_mode, ['sip','dip','primary','blade','l4-src-port','l4-dst-port']
property :uuid, String
property :untagged_trunk_list, Array
property :untagged_lif, Integer
property :untagged_eth_list, Array
property :user_tag, String
property :vlan_num, Integer,required: true
property :sampling_enable, Array
property :tagged_trunk_list, Array
property :shared_vlan, [true, false]
property :tagged_eth_list, Array
property :ve, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/vlan/"
    get_url = "/axapi/v3/network/vlan/%<vlan-num>s"
    traffic_distribution_mode = new_resource.traffic_distribution_mode
    uuid = new_resource.uuid
    untagged_trunk_list = new_resource.untagged_trunk_list
    untagged_lif = new_resource.untagged_lif
    untagged_eth_list = new_resource.untagged_eth_list
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    vlan_num = new_resource.vlan_num
    sampling_enable = new_resource.sampling_enable
    tagged_trunk_list = new_resource.tagged_trunk_list
    shared_vlan = new_resource.shared_vlan
    tagged_eth_list = new_resource.tagged_eth_list
    ve = new_resource.ve

    params = { "vlan": {"traffic-distribution-mode": traffic_distribution_mode,
        "uuid": uuid,
        "untagged-trunk-list": untagged_trunk_list,
        "untagged-lif": untagged_lif,
        "untagged-eth-list": untagged_eth_list,
        "user-tag": user_tag,
        "name": a10_name,
        "vlan-num": vlan_num,
        "sampling-enable": sampling_enable,
        "tagged-trunk-list": tagged_trunk_list,
        "shared-vlan": shared_vlan,
        "tagged-eth-list": tagged_eth_list,
        "ve": ve,} }

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
    url = "/axapi/v3/network/vlan/%<vlan-num>s"
    traffic_distribution_mode = new_resource.traffic_distribution_mode
    uuid = new_resource.uuid
    untagged_trunk_list = new_resource.untagged_trunk_list
    untagged_lif = new_resource.untagged_lif
    untagged_eth_list = new_resource.untagged_eth_list
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    vlan_num = new_resource.vlan_num
    sampling_enable = new_resource.sampling_enable
    tagged_trunk_list = new_resource.tagged_trunk_list
    shared_vlan = new_resource.shared_vlan
    tagged_eth_list = new_resource.tagged_eth_list
    ve = new_resource.ve

    params = { "vlan": {"traffic-distribution-mode": traffic_distribution_mode,
        "uuid": uuid,
        "untagged-trunk-list": untagged_trunk_list,
        "untagged-lif": untagged_lif,
        "untagged-eth-list": untagged_eth_list,
        "user-tag": user_tag,
        "name": a10_name,
        "vlan-num": vlan_num,
        "sampling-enable": sampling_enable,
        "tagged-trunk-list": tagged_trunk_list,
        "shared-vlan": shared_vlan,
        "tagged-eth-list": tagged_eth_list,
        "ve": ve,} }

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
    url = "/axapi/v3/network/vlan/%<vlan-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vlan') do
            client.delete(url)
        end
    end
end