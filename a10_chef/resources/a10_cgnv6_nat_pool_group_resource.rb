resource_name :a10_cgnv6_nat_pool_group

property :a10_name, String, name_property: true
property :member_list, Array
property :pool_group_name, String,required: true
property :vrid, Integer
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat/pool-group/"
    get_url = "/axapi/v3/cgnv6/nat/pool-group/%<pool-group-name>s"
    member_list = new_resource.member_list
    pool_group_name = new_resource.pool_group_name
    vrid = new_resource.vrid
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "pool-group": {"member-list": member_list,
        "pool-group-name": pool_group_name,
        "vrid": vrid,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"pool-group"].each do |k, v|
        if not v 
            params[:"pool-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pool-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/pool-group/%<pool-group-name>s"
    member_list = new_resource.member_list
    pool_group_name = new_resource.pool_group_name
    vrid = new_resource.vrid
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "pool-group": {"member-list": member_list,
        "pool-group-name": pool_group_name,
        "vrid": vrid,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"pool-group"].each do |k, v|
        if not v
            params[:"pool-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pool-group"].each do |k, v|
        if v != params[:"pool-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pool-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/pool-group/%<pool-group-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pool-group') do
            client.delete(url)
        end
    end
end