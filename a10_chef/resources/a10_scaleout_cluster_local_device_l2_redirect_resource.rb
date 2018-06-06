resource_name :a10_scaleout_cluster_local_device_l2_redirect

property :a10_name, String, name_property: true
property :ethernet_vlan, Integer
property :redirect_eth, String
property :redirect_trunk, Integer
property :trunk_vlan, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device/"
    get_url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device/l2-redirect"
    ethernet_vlan = new_resource.ethernet_vlan
    redirect_eth = new_resource.redirect_eth
    redirect_trunk = new_resource.redirect_trunk
    trunk_vlan = new_resource.trunk_vlan
    uuid = new_resource.uuid

    params = { "l2-redirect": {"ethernet-vlan": ethernet_vlan,
        "redirect-eth": redirect_eth,
        "redirect-trunk": redirect_trunk,
        "trunk-vlan": trunk_vlan,
        "uuid": uuid,} }

    params[:"l2-redirect"].each do |k, v|
        if not v 
            params[:"l2-redirect"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l2-redirect') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device/l2-redirect"
    ethernet_vlan = new_resource.ethernet_vlan
    redirect_eth = new_resource.redirect_eth
    redirect_trunk = new_resource.redirect_trunk
    trunk_vlan = new_resource.trunk_vlan
    uuid = new_resource.uuid

    params = { "l2-redirect": {"ethernet-vlan": ethernet_vlan,
        "redirect-eth": redirect_eth,
        "redirect-trunk": redirect_trunk,
        "trunk-vlan": trunk_vlan,
        "uuid": uuid,} }

    params[:"l2-redirect"].each do |k, v|
        if not v
            params[:"l2-redirect"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l2-redirect"].each do |k, v|
        if v != params[:"l2-redirect"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l2-redirect') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout/cluster/%<cluster-id>s/local-device/l2-redirect"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l2-redirect') do
            client.delete(url)
        end
    end
end