resource_name :a10_network_lldp_management_address_ipv6_addr

property :a10_name, String, name_property: true
property :ipv6, String,required: true
property :uuid, String
property :interface_ipv6, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/lldp/management-address/ipv6-addr/"
    get_url = "/axapi/v3/network/lldp/management-address/ipv6-addr/%<ipv6>s"
    ipv6 = new_resource.ipv6
    uuid = new_resource.uuid
    interface_ipv6 = new_resource.interface_ipv6

    params = { "ipv6-addr": {"ipv6": ipv6,
        "uuid": uuid,
        "interface-ipv6": interface_ipv6,} }

    params[:"ipv6-addr"].each do |k, v|
        if not v 
            params[:"ipv6-addr"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6-addr') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lldp/management-address/ipv6-addr/%<ipv6>s"
    ipv6 = new_resource.ipv6
    uuid = new_resource.uuid
    interface_ipv6 = new_resource.interface_ipv6

    params = { "ipv6-addr": {"ipv6": ipv6,
        "uuid": uuid,
        "interface-ipv6": interface_ipv6,} }

    params[:"ipv6-addr"].each do |k, v|
        if not v
            params[:"ipv6-addr"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6-addr"].each do |k, v|
        if v != params[:"ipv6-addr"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6-addr') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/lldp/management-address/ipv6-addr/%<ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6-addr') do
            client.delete(url)
        end
    end
end