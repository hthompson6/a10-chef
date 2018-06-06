resource_name :a10_cgnv6_sixrd_domain

property :a10_name, String, name_property: true
property :ipv6_prefix, String
property :ce_ipv4_network, String
property :user_tag, String
property :mtu, Integer
property :ce_ipv4_netmask, String
property :sampling_enable, Array
property :br_ipv4_address, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/sixrd/domain/"
    get_url = "/axapi/v3/cgnv6/sixrd/domain/%<name>s"
    ipv6_prefix = new_resource.ipv6_prefix
    a10_name = new_resource.a10_name
    ce_ipv4_network = new_resource.ce_ipv4_network
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ce_ipv4_netmask = new_resource.ce_ipv4_netmask
    sampling_enable = new_resource.sampling_enable
    br_ipv4_address = new_resource.br_ipv4_address
    uuid = new_resource.uuid

    params = { "domain": {"ipv6-prefix": ipv6_prefix,
        "name": a10_name,
        "ce-ipv4-network": ce_ipv4_network,
        "user-tag": user_tag,
        "mtu": mtu,
        "ce-ipv4-netmask": ce_ipv4_netmask,
        "sampling-enable": sampling_enable,
        "br-ipv4-address": br_ipv4_address,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v 
            params[:"domain"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sixrd/domain/%<name>s"
    ipv6_prefix = new_resource.ipv6_prefix
    a10_name = new_resource.a10_name
    ce_ipv4_network = new_resource.ce_ipv4_network
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ce_ipv4_netmask = new_resource.ce_ipv4_netmask
    sampling_enable = new_resource.sampling_enable
    br_ipv4_address = new_resource.br_ipv4_address
    uuid = new_resource.uuid

    params = { "domain": {"ipv6-prefix": ipv6_prefix,
        "name": a10_name,
        "ce-ipv4-network": ce_ipv4_network,
        "user-tag": user_tag,
        "mtu": mtu,
        "ce-ipv4-netmask": ce_ipv4_netmask,
        "sampling-enable": sampling_enable,
        "br-ipv4-address": br_ipv4_address,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v
            params[:"domain"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain"].each do |k, v|
        if v != params[:"domain"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sixrd/domain/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain') do
            client.delete(url)
        end
    end
end