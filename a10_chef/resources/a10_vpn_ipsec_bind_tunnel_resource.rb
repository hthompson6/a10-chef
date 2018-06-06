resource_name :a10_vpn_ipsec_bind_tunnel

property :a10_name, String, name_property: true
property :tunnel, Integer
property :next_hop, String
property :uuid, String
property :next_hop_v6, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vpn/ipsec/%<name>s/"
    get_url = "/axapi/v3/vpn/ipsec/%<name>s/bind-tunnel"
    tunnel = new_resource.tunnel
    next_hop = new_resource.next_hop
    uuid = new_resource.uuid
    next_hop_v6 = new_resource.next_hop_v6

    params = { "bind-tunnel": {"tunnel": tunnel,
        "next-hop": next_hop,
        "uuid": uuid,
        "next-hop-v6": next_hop_v6,} }

    params[:"bind-tunnel"].each do |k, v|
        if not v 
            params[:"bind-tunnel"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bind-tunnel') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ipsec/%<name>s/bind-tunnel"
    tunnel = new_resource.tunnel
    next_hop = new_resource.next_hop
    uuid = new_resource.uuid
    next_hop_v6 = new_resource.next_hop_v6

    params = { "bind-tunnel": {"tunnel": tunnel,
        "next-hop": next_hop,
        "uuid": uuid,
        "next-hop-v6": next_hop_v6,} }

    params[:"bind-tunnel"].each do |k, v|
        if not v
            params[:"bind-tunnel"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bind-tunnel"].each do |k, v|
        if v != params[:"bind-tunnel"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bind-tunnel') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ipsec/%<name>s/bind-tunnel"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bind-tunnel') do
            client.delete(url)
        end
    end
end