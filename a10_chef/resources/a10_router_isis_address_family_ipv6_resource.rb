resource_name :a10_router_isis_address_family_ipv6

property :a10_name, String, name_property: true
property :distance, Integer
property :redistribute, Hash
property :uuid, String
property :multi_topology_cfg, Hash
property :adjacency_check, [true, false]
property :summary_prefix_list, Array
property :default_information, ['originate']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/isis/%<tag>s/address-family/"
    get_url = "/axapi/v3/router/isis/%<tag>s/address-family/ipv6"
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    uuid = new_resource.uuid
    multi_topology_cfg = new_resource.multi_topology_cfg
    adjacency_check = new_resource.adjacency_check
    summary_prefix_list = new_resource.summary_prefix_list
    default_information = new_resource.default_information

    params = { "ipv6": {"distance": distance,
        "redistribute": redistribute,
        "uuid": uuid,
        "multi-topology-cfg": multi_topology_cfg,
        "adjacency-check": adjacency_check,
        "summary-prefix-list": summary_prefix_list,
        "default-information": default_information,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/isis/%<tag>s/address-family/ipv6"
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    uuid = new_resource.uuid
    multi_topology_cfg = new_resource.multi_topology_cfg
    adjacency_check = new_resource.adjacency_check
    summary_prefix_list = new_resource.summary_prefix_list
    default_information = new_resource.default_information

    params = { "ipv6": {"distance": distance,
        "redistribute": redistribute,
        "uuid": uuid,
        "multi-topology-cfg": multi_topology_cfg,
        "adjacency-check": adjacency_check,
        "summary-prefix-list": summary_prefix_list,
        "default-information": default_information,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/isis/%<tag>s/address-family/ipv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end