resource_name :a10_cgnv6_lw_4o6_binding_table_tunnel_address_nat_address

property :a10_name, String, name_property: true
property :ipv4_nat_addr, String,required: true
property :port_range_list, Array
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/"
    get_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s"
    ipv4_nat_addr = new_resource.ipv4_nat_addr
    port_range_list = new_resource.port_range_list
    user_tag = new_resource.user_tag

    params = { "nat-address": {"ipv4-nat-addr": ipv4_nat_addr,
        "port-range-list": port_range_list,
        "user-tag": user_tag,} }

    params[:"nat-address"].each do |k, v|
        if not v 
            params[:"nat-address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nat-address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s"
    ipv4_nat_addr = new_resource.ipv4_nat_addr
    port_range_list = new_resource.port_range_list
    user_tag = new_resource.user_tag

    params = { "nat-address": {"ipv4-nat-addr": ipv4_nat_addr,
        "port-range-list": port_range_list,
        "user-tag": user_tag,} }

    params[:"nat-address"].each do |k, v|
        if not v
            params[:"nat-address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nat-address"].each do |k, v|
        if v != params[:"nat-address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nat-address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s/nat-address/%<ipv4-nat-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nat-address') do
            client.delete(url)
        end
    end
end