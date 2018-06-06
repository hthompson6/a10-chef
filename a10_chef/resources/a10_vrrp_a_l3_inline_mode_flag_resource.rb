resource_name :a10_vrrp_a_l3_inline_mode_flag

property :a10_name, String, name_property: true
property :uuid, String
property :l3_inline_mode, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/"
    get_url = "/axapi/v3/vrrp-a/l3-inline-mode-flag"
    uuid = new_resource.uuid
    l3_inline_mode = new_resource.l3_inline_mode

    params = { "l3-inline-mode-flag": {"uuid": uuid,
        "l3-inline-mode": l3_inline_mode,} }

    params[:"l3-inline-mode-flag"].each do |k, v|
        if not v 
            params[:"l3-inline-mode-flag"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l3-inline-mode-flag') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/l3-inline-mode-flag"
    uuid = new_resource.uuid
    l3_inline_mode = new_resource.l3_inline_mode

    params = { "l3-inline-mode-flag": {"uuid": uuid,
        "l3-inline-mode": l3_inline_mode,} }

    params[:"l3-inline-mode-flag"].each do |k, v|
        if not v
            params[:"l3-inline-mode-flag"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l3-inline-mode-flag"].each do |k, v|
        if v != params[:"l3-inline-mode-flag"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l3-inline-mode-flag') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/l3-inline-mode-flag"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l3-inline-mode-flag') do
            client.delete(url)
        end
    end
end