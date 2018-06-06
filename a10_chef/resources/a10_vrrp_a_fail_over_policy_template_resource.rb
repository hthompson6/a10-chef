resource_name :a10_vrrp_a_fail_over_policy_template

property :a10_name, String, name_property: true
property :vlan_cfg, Array
property :route, Hash
property :user_tag, String
property :bgp, Hash
property :interface, Array
property :gateway, Hash
property :trunk_cfg, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/fail-over-policy-template/"
    get_url = "/axapi/v3/vrrp-a/fail-over-policy-template/%<name>s"
    vlan_cfg = new_resource.vlan_cfg
    a10_name = new_resource.a10_name
    route = new_resource.route
    user_tag = new_resource.user_tag
    bgp = new_resource.bgp
    interface = new_resource.interface
    gateway = new_resource.gateway
    trunk_cfg = new_resource.trunk_cfg
    uuid = new_resource.uuid

    params = { "fail-over-policy-template": {"vlan-cfg": vlan_cfg,
        "name": a10_name,
        "route": route,
        "user-tag": user_tag,
        "bgp": bgp,
        "interface": interface,
        "gateway": gateway,
        "trunk-cfg": trunk_cfg,
        "uuid": uuid,} }

    params[:"fail-over-policy-template"].each do |k, v|
        if not v 
            params[:"fail-over-policy-template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating fail-over-policy-template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/fail-over-policy-template/%<name>s"
    vlan_cfg = new_resource.vlan_cfg
    a10_name = new_resource.a10_name
    route = new_resource.route
    user_tag = new_resource.user_tag
    bgp = new_resource.bgp
    interface = new_resource.interface
    gateway = new_resource.gateway
    trunk_cfg = new_resource.trunk_cfg
    uuid = new_resource.uuid

    params = { "fail-over-policy-template": {"vlan-cfg": vlan_cfg,
        "name": a10_name,
        "route": route,
        "user-tag": user_tag,
        "bgp": bgp,
        "interface": interface,
        "gateway": gateway,
        "trunk-cfg": trunk_cfg,
        "uuid": uuid,} }

    params[:"fail-over-policy-template"].each do |k, v|
        if not v
            params[:"fail-over-policy-template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["fail-over-policy-template"].each do |k, v|
        if v != params[:"fail-over-policy-template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating fail-over-policy-template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/fail-over-policy-template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting fail-over-policy-template') do
            client.delete(url)
        end
    end
end