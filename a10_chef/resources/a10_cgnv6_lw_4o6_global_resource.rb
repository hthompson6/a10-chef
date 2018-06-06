resource_name :a10_cgnv6_lw_4o6_global

property :a10_name, String, name_property: true
property :no_forward_match, Hash
property :nat_prefix_list, String
property :uuid, String
property :hairpinning, ['filter-all','filter-none','filter-self-ip','filter-self-ip-port']
property :inside_src_access_list, Integer
property :sampling_enable, Array
property :icmp_inbound, ['drop','handle']
property :use_binding_table, String
property :no_reverse_match, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lw-4o6/"
    get_url = "/axapi/v3/cgnv6/lw-4o6/global"
    no_forward_match = new_resource.no_forward_match
    nat_prefix_list = new_resource.nat_prefix_list
    uuid = new_resource.uuid
    hairpinning = new_resource.hairpinning
    inside_src_access_list = new_resource.inside_src_access_list
    sampling_enable = new_resource.sampling_enable
    icmp_inbound = new_resource.icmp_inbound
    use_binding_table = new_resource.use_binding_table
    no_reverse_match = new_resource.no_reverse_match

    params = { "global": {"no-forward-match": no_forward_match,
        "nat-prefix-list": nat_prefix_list,
        "uuid": uuid,
        "hairpinning": hairpinning,
        "inside-src-access-list": inside_src_access_list,
        "sampling-enable": sampling_enable,
        "icmp-inbound": icmp_inbound,
        "use-binding-table": use_binding_table,
        "no-reverse-match": no_reverse_match,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/global"
    no_forward_match = new_resource.no_forward_match
    nat_prefix_list = new_resource.nat_prefix_list
    uuid = new_resource.uuid
    hairpinning = new_resource.hairpinning
    inside_src_access_list = new_resource.inside_src_access_list
    sampling_enable = new_resource.sampling_enable
    icmp_inbound = new_resource.icmp_inbound
    use_binding_table = new_resource.use_binding_table
    no_reverse_match = new_resource.no_reverse_match

    params = { "global": {"no-forward-match": no_forward_match,
        "nat-prefix-list": nat_prefix_list,
        "uuid": uuid,
        "hairpinning": hairpinning,
        "inside-src-access-list": inside_src_access_list,
        "sampling-enable": sampling_enable,
        "icmp-inbound": icmp_inbound,
        "use-binding-table": use_binding_table,
        "no-reverse-match": no_reverse_match,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end