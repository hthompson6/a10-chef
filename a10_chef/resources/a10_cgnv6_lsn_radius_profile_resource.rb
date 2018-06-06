resource_name :a10_cgnv6_lsn_radius_profile

property :a10_name, String, name_property: true
property :lid_profile_index, Integer,required: true
property :radius, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-radius-profile/"
    get_url = "/axapi/v3/cgnv6/lsn-radius-profile/%<lid-profile-index>s"
    lid_profile_index = new_resource.lid_profile_index
    radius = new_resource.radius
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "lsn-radius-profile": {"lid-profile-index": lid_profile_index,
        "radius": radius,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"lsn-radius-profile"].each do |k, v|
        if not v 
            params[:"lsn-radius-profile"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lsn-radius-profile') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-radius-profile/%<lid-profile-index>s"
    lid_profile_index = new_resource.lid_profile_index
    radius = new_resource.radius
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "lsn-radius-profile": {"lid-profile-index": lid_profile_index,
        "radius": radius,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"lsn-radius-profile"].each do |k, v|
        if not v
            params[:"lsn-radius-profile"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lsn-radius-profile"].each do |k, v|
        if v != params[:"lsn-radius-profile"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lsn-radius-profile') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-radius-profile/%<lid-profile-index>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lsn-radius-profile') do
            client.delete(url)
        end
    end
end