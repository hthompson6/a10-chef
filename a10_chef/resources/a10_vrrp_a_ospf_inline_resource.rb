resource_name :a10_vrrp_a_ospf_inline

property :a10_name, String, name_property: true
property :vlan, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/ospf-inline/"
    get_url = "/axapi/v3/vrrp-a/ospf-inline/%<vlan>s"
    vlan = new_resource.vlan
    uuid = new_resource.uuid

    params = { "ospf-inline": {"vlan": vlan,
        "uuid": uuid,} }

    params[:"ospf-inline"].each do |k, v|
        if not v 
            params[:"ospf-inline"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf-inline') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/ospf-inline/%<vlan>s"
    vlan = new_resource.vlan
    uuid = new_resource.uuid

    params = { "ospf-inline": {"vlan": vlan,
        "uuid": uuid,} }

    params[:"ospf-inline"].each do |k, v|
        if not v
            params[:"ospf-inline"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf-inline"].each do |k, v|
        if v != params[:"ospf-inline"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf-inline') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/ospf-inline/%<vlan>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf-inline') do
            client.delete(url)
        end
    end
end