resource_name :a10_network_lldp_management_address_ipv4_addr

property :a10_name, String, name_property: true
property :interface_ipv4, Hash
property :uuid, String
property :ipv4, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/lldp/management-address/ipv4-addr/"
    get_url = "/axapi/v3/network/lldp/management-address/ipv4-addr/%<ipv4>s"
    interface_ipv4 = new_resource.interface_ipv4
    uuid = new_resource.uuid
    ipv4 = new_resource.ipv4

    params = { "ipv4-addr": {"interface-ipv4": interface_ipv4,
        "uuid": uuid,
        "ipv4": ipv4,} }

    params[:"ipv4-addr"].each do |k, v|
        if not v 
            params[:"ipv4-addr"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4-addr') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lldp/management-address/ipv4-addr/%<ipv4>s"
    interface_ipv4 = new_resource.interface_ipv4
    uuid = new_resource.uuid
    ipv4 = new_resource.ipv4

    params = { "ipv4-addr": {"interface-ipv4": interface_ipv4,
        "uuid": uuid,
        "ipv4": ipv4,} }

    params[:"ipv4-addr"].each do |k, v|
        if not v
            params[:"ipv4-addr"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4-addr"].each do |k, v|
        if v != params[:"ipv4-addr"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4-addr') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lldp/management-address/ipv4-addr/%<ipv4>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4-addr') do
            client.delete(url)
        end
    end
end