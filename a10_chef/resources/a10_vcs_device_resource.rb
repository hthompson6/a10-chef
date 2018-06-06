resource_name :a10_vcs_device

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String
property :ethernet_cfg, Array
property :user_tag, String
property :priority, Integer
property :management, [true, false]
property :ve_cfg, Array
property :device, Integer,required: true
property :affinity_vrrp_a_vrid, Integer
property :unicast_port, Integer
property :trunk_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/device/"
    get_url = "/axapi/v3/vcs/device/%<device>s"
    enable = new_resource.enable
    uuid = new_resource.uuid
    ethernet_cfg = new_resource.ethernet_cfg
    user_tag = new_resource.user_tag
    priority = new_resource.priority
    management = new_resource.management
    ve_cfg = new_resource.ve_cfg
    device = new_resource.device
    affinity_vrrp_a_vrid = new_resource.affinity_vrrp_a_vrid
    unicast_port = new_resource.unicast_port
    trunk_cfg = new_resource.trunk_cfg

    params = { "device": {"enable": enable,
        "uuid": uuid,
        "ethernet-cfg": ethernet_cfg,
        "user-tag": user_tag,
        "priority": priority,
        "management": management,
        "ve-cfg": ve_cfg,
        "device": device,
        "affinity-vrrp-a-vrid": affinity_vrrp_a_vrid,
        "unicast-port": unicast_port,
        "trunk-cfg": trunk_cfg,} }

    params[:"device"].each do |k, v|
        if not v 
            params[:"device"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating device') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/device/%<device>s"
    enable = new_resource.enable
    uuid = new_resource.uuid
    ethernet_cfg = new_resource.ethernet_cfg
    user_tag = new_resource.user_tag
    priority = new_resource.priority
    management = new_resource.management
    ve_cfg = new_resource.ve_cfg
    device = new_resource.device
    affinity_vrrp_a_vrid = new_resource.affinity_vrrp_a_vrid
    unicast_port = new_resource.unicast_port
    trunk_cfg = new_resource.trunk_cfg

    params = { "device": {"enable": enable,
        "uuid": uuid,
        "ethernet-cfg": ethernet_cfg,
        "user-tag": user_tag,
        "priority": priority,
        "management": management,
        "ve-cfg": ve_cfg,
        "device": device,
        "affinity-vrrp-a-vrid": affinity_vrrp_a_vrid,
        "unicast-port": unicast_port,
        "trunk-cfg": trunk_cfg,} }

    params[:"device"].each do |k, v|
        if not v
            params[:"device"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["device"].each do |k, v|
        if v != params[:"device"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating device') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/device/%<device>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting device') do
            client.delete(url)
        end
    end
end