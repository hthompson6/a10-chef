resource_name :a10_vrrp_a_vrid

property :a10_name, String, name_property: true
property :blade_parameters, Hash
property :uuid, String
property :vrid_val, Integer,required: true
property :user_tag, String
property :preempt_mode, Hash
property :floating_ip, Hash
property :follow, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/vrid/"
    get_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s"
    blade_parameters = new_resource.blade_parameters
    uuid = new_resource.uuid
    vrid_val = new_resource.vrid_val
    user_tag = new_resource.user_tag
    preempt_mode = new_resource.preempt_mode
    floating_ip = new_resource.floating_ip
    follow = new_resource.follow

    params = { "vrid": {"blade-parameters": blade_parameters,
        "uuid": uuid,
        "vrid-val": vrid_val,
        "user-tag": user_tag,
        "preempt-mode": preempt_mode,
        "floating-ip": floating_ip,
        "follow": follow,} }

    params[:"vrid"].each do |k, v|
        if not v 
            params[:"vrid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vrid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s"
    blade_parameters = new_resource.blade_parameters
    uuid = new_resource.uuid
    vrid_val = new_resource.vrid_val
    user_tag = new_resource.user_tag
    preempt_mode = new_resource.preempt_mode
    floating_ip = new_resource.floating_ip
    follow = new_resource.follow

    params = { "vrid": {"blade-parameters": blade_parameters,
        "uuid": uuid,
        "vrid-val": vrid_val,
        "user-tag": user_tag,
        "preempt-mode": preempt_mode,
        "floating-ip": floating_ip,
        "follow": follow,} }

    params[:"vrid"].each do |k, v|
        if not v
            params[:"vrid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vrid"].each do |k, v|
        if v != params[:"vrid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vrid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vrid') do
            client.delete(url)
        end
    end
end