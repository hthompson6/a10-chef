resource_name :a10_vrrp_a_vrid_blade_parameters_tracking_options

property :a10_name, String, name_property: true
property :vlan_cfg, Array
property :uuid, String
property :route, Hash
property :bgp, Hash
property :interface, Array
property :gateway, Hash
property :trunk_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/"
    get_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options"
    vlan_cfg = new_resource.vlan_cfg
    uuid = new_resource.uuid
    route = new_resource.route
    bgp = new_resource.bgp
    interface = new_resource.interface
    gateway = new_resource.gateway
    trunk_cfg = new_resource.trunk_cfg

    params = { "tracking-options": {"vlan-cfg": vlan_cfg,
        "uuid": uuid,
        "route": route,
        "bgp": bgp,
        "interface": interface,
        "gateway": gateway,
        "trunk-cfg": trunk_cfg,} }

    params[:"tracking-options"].each do |k, v|
        if not v 
            params[:"tracking-options"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tracking-options') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options"
    vlan_cfg = new_resource.vlan_cfg
    uuid = new_resource.uuid
    route = new_resource.route
    bgp = new_resource.bgp
    interface = new_resource.interface
    gateway = new_resource.gateway
    trunk_cfg = new_resource.trunk_cfg

    params = { "tracking-options": {"vlan-cfg": vlan_cfg,
        "uuid": uuid,
        "route": route,
        "bgp": bgp,
        "interface": interface,
        "gateway": gateway,
        "trunk-cfg": trunk_cfg,} }

    params[:"tracking-options"].each do |k, v|
        if not v
            params[:"tracking-options"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tracking-options"].each do |k, v|
        if v != params[:"tracking-options"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tracking-options') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tracking-options') do
            client.delete(url)
        end
    end
end