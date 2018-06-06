resource_name :a10_interface_ve_ipv6_rip

property :a10_name, String, name_property: true
property :split_horizon_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/rip"
    split_horizon_cfg = new_resource.split_horizon_cfg
    uuid = new_resource.uuid

    params = { "rip": {"split-horizon-cfg": split_horizon_cfg,
        "uuid": uuid,} }

    params[:"rip"].each do |k, v|
        if not v 
            params[:"rip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/rip"
    split_horizon_cfg = new_resource.split_horizon_cfg
    uuid = new_resource.uuid

    params = { "rip": {"split-horizon-cfg": split_horizon_cfg,
        "uuid": uuid,} }

    params[:"rip"].each do |k, v|
        if not v
            params[:"rip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rip"].each do |k, v|
        if v != params[:"rip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ipv6/rip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rip') do
            client.delete(url)
        end
    end
end