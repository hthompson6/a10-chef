resource_name :a10_cgnv6_lw_4o6_binding_table_tunnel_address

property :a10_name, String, name_property: true
property :ipv6_tunnel_addr, String,required: true
property :user_tag, String
property :nat_address_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/"
    get_url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s"
    ipv6_tunnel_addr = new_resource.ipv6_tunnel_addr
    user_tag = new_resource.user_tag
    nat_address_list = new_resource.nat_address_list

    params = { "tunnel-address": {"ipv6-tunnel-addr": ipv6_tunnel_addr,
        "user-tag": user_tag,
        "nat-address-list": nat_address_list,} }

    params[:"tunnel-address"].each do |k, v|
        if not v 
            params[:"tunnel-address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tunnel-address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s"
    ipv6_tunnel_addr = new_resource.ipv6_tunnel_addr
    user_tag = new_resource.user_tag
    nat_address_list = new_resource.nat_address_list

    params = { "tunnel-address": {"ipv6-tunnel-addr": ipv6_tunnel_addr,
        "user-tag": user_tag,
        "nat-address-list": nat_address_list,} }

    params[:"tunnel-address"].each do |k, v|
        if not v
            params[:"tunnel-address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tunnel-address"].each do |k, v|
        if v != params[:"tunnel-address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tunnel-address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/binding-table/%<name>s/tunnel-address/%<ipv6-tunnel-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tunnel-address') do
            client.delete(url)
        end
    end
end