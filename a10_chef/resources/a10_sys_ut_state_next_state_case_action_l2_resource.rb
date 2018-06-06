resource_name :a10_sys_ut_state_next_state_case_action_l2

property :a10_name, String, name_property: true
property :protocol, ['arp','ipv4','ipv6']
property :uuid, String
property :ethertype, [true, false]
property :mac_list, Array
property :vlan, Integer
property :value, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/"
    get_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/l2"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    ethertype = new_resource.ethertype
    mac_list = new_resource.mac_list
    vlan = new_resource.vlan
    value = new_resource.value

    params = { "l2": {"protocol": protocol,
        "uuid": uuid,
        "ethertype": ethertype,
        "mac-list": mac_list,
        "vlan": vlan,
        "value": value,} }

    params[:"l2"].each do |k, v|
        if not v 
            params[:"l2"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l2') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/l2"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    ethertype = new_resource.ethertype
    mac_list = new_resource.mac_list
    vlan = new_resource.vlan
    value = new_resource.value

    params = { "l2": {"protocol": protocol,
        "uuid": uuid,
        "ethertype": ethertype,
        "mac-list": mac_list,
        "vlan": vlan,
        "value": value,} }

    params[:"l2"].each do |k, v|
        if not v
            params[:"l2"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l2"].each do |k, v|
        if v != params[:"l2"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l2') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/l2"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l2') do
            client.delete(url)
        end
    end
end