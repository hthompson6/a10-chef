resource_name :a10_router_bgp_address_family_ipv6_network_synchronization

property :a10_name, String, name_property: true
property :network_synchronization, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/synchronization"
    network_synchronization = new_resource.network_synchronization
    uuid = new_resource.uuid

    params = { "synchronization": {"network-synchronization": network_synchronization,
        "uuid": uuid,} }

    params[:"synchronization"].each do |k, v|
        if not v 
            params[:"synchronization"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating synchronization') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/synchronization"
    network_synchronization = new_resource.network_synchronization
    uuid = new_resource.uuid

    params = { "synchronization": {"network-synchronization": network_synchronization,
        "uuid": uuid,} }

    params[:"synchronization"].each do |k, v|
        if not v
            params[:"synchronization"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["synchronization"].each do |k, v|
        if v != params[:"synchronization"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating synchronization') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/network/synchronization"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting synchronization') do
            client.delete(url)
        end
    end
end