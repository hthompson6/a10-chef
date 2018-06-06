resource_name :a10_system_all_vlan_limit

property :a10_name, String, name_property: true
property :unknown_ucast, Integer
property :bcast, Integer
property :mcast, Integer
property :ipmcast, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/all-vlan-limit"
    unknown_ucast = new_resource.unknown_ucast
    bcast = new_resource.bcast
    mcast = new_resource.mcast
    ipmcast = new_resource.ipmcast
    uuid = new_resource.uuid

    params = { "all-vlan-limit": {"unknown-ucast": unknown_ucast,
        "bcast": bcast,
        "mcast": mcast,
        "ipmcast": ipmcast,
        "uuid": uuid,} }

    params[:"all-vlan-limit"].each do |k, v|
        if not v 
            params[:"all-vlan-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating all-vlan-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/all-vlan-limit"
    unknown_ucast = new_resource.unknown_ucast
    bcast = new_resource.bcast
    mcast = new_resource.mcast
    ipmcast = new_resource.ipmcast
    uuid = new_resource.uuid

    params = { "all-vlan-limit": {"unknown-ucast": unknown_ucast,
        "bcast": bcast,
        "mcast": mcast,
        "ipmcast": ipmcast,
        "uuid": uuid,} }

    params[:"all-vlan-limit"].each do |k, v|
        if not v
            params[:"all-vlan-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["all-vlan-limit"].each do |k, v|
        if v != params[:"all-vlan-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating all-vlan-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/all-vlan-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting all-vlan-limit') do
            client.delete(url)
        end
    end
end