resource_name :a10_cgnv6_nat46_stateless_fragmentation_outbound

property :a10_name, String, name_property: true
property :count, Integer
property :a10_action, ['drop','ipv6']
property :df_set, ['drop','ipv6','send-icmp']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat46-stateless/fragmentation/"
    get_url = "/axapi/v3/cgnv6/nat46-stateless/fragmentation/outbound"
    count = new_resource.count
    a10_name = new_resource.a10_name
    df_set = new_resource.df_set
    uuid = new_resource.uuid

    params = { "outbound": {"count": count,
        "action": a10_action,
        "df-set": df_set,
        "uuid": uuid,} }

    params[:"outbound"].each do |k, v|
        if not v 
            params[:"outbound"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating outbound') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/fragmentation/outbound"
    count = new_resource.count
    a10_name = new_resource.a10_name
    df_set = new_resource.df_set
    uuid = new_resource.uuid

    params = { "outbound": {"count": count,
        "action": a10_action,
        "df-set": df_set,
        "uuid": uuid,} }

    params[:"outbound"].each do |k, v|
        if not v
            params[:"outbound"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["outbound"].each do |k, v|
        if v != params[:"outbound"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating outbound') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat46-stateless/fragmentation/outbound"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting outbound') do
            client.delete(url)
        end
    end
end