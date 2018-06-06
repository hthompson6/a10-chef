resource_name :a10_cgnv6_nat64_global

property :a10_name, String, name_property: true
property :user_quota_prefix_length, Integer
property :all, [true, false]
property :uuid, String
property :inside, Hash
property :tcp, Hash
property :force_non_zero_ipv4_id, [true, false]
property :icmp, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat64/"
    get_url = "/axapi/v3/cgnv6/nat64/global"
    user_quota_prefix_length = new_resource.user_quota_prefix_length
    all = new_resource.all
    uuid = new_resource.uuid
    inside = new_resource.inside
    tcp = new_resource.tcp
    force_non_zero_ipv4_id = new_resource.force_non_zero_ipv4_id
    icmp = new_resource.icmp

    params = { "global": {"user-quota-prefix-length": user_quota_prefix_length,
        "all": all,
        "uuid": uuid,
        "inside": inside,
        "tcp": tcp,
        "force-non-zero-ipv4-id": force_non_zero_ipv4_id,
        "icmp": icmp,} }

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
    url = "/axapi/v3/cgnv6/nat64/global"
    user_quota_prefix_length = new_resource.user_quota_prefix_length
    all = new_resource.all
    uuid = new_resource.uuid
    inside = new_resource.inside
    tcp = new_resource.tcp
    force_non_zero_ipv4_id = new_resource.force_non_zero_ipv4_id
    icmp = new_resource.icmp

    params = { "global": {"user-quota-prefix-length": user_quota_prefix_length,
        "all": all,
        "uuid": uuid,
        "inside": inside,
        "tcp": tcp,
        "force-non-zero-ipv4-id": force_non_zero_ipv4_id,
        "icmp": icmp,} }

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
    url = "/axapi/v3/cgnv6/nat64/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end