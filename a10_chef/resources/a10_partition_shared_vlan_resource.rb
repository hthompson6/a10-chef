resource_name :a10_partition_shared_vlan

property :a10_name, String, name_property: true
property :mgmt_floating_ip_address, String
property :allowable_ip_range, Array
property :vrid, Integer
property :allowable_ipv6_range, Array
property :vlan, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/partition/%<partition-name>s/"
    get_url = "/axapi/v3/partition/%<partition-name>s/shared-vlan"
    mgmt_floating_ip_address = new_resource.mgmt_floating_ip_address
    allowable_ip_range = new_resource.allowable_ip_range
    vrid = new_resource.vrid
    allowable_ipv6_range = new_resource.allowable_ipv6_range
    vlan = new_resource.vlan
    uuid = new_resource.uuid

    params = { "shared-vlan": {"mgmt-floating-ip-address": mgmt_floating_ip_address,
        "allowable-ip-range": allowable_ip_range,
        "vrid": vrid,
        "allowable-ipv6-range": allowable_ipv6_range,
        "vlan": vlan,
        "uuid": uuid,} }

    params[:"shared-vlan"].each do |k, v|
        if not v 
            params[:"shared-vlan"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating shared-vlan') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/partition/%<partition-name>s/shared-vlan"
    mgmt_floating_ip_address = new_resource.mgmt_floating_ip_address
    allowable_ip_range = new_resource.allowable_ip_range
    vrid = new_resource.vrid
    allowable_ipv6_range = new_resource.allowable_ipv6_range
    vlan = new_resource.vlan
    uuid = new_resource.uuid

    params = { "shared-vlan": {"mgmt-floating-ip-address": mgmt_floating_ip_address,
        "allowable-ip-range": allowable_ip_range,
        "vrid": vrid,
        "allowable-ipv6-range": allowable_ipv6_range,
        "vlan": vlan,
        "uuid": uuid,} }

    params[:"shared-vlan"].each do |k, v|
        if not v
            params[:"shared-vlan"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["shared-vlan"].each do |k, v|
        if v != params[:"shared-vlan"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating shared-vlan') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/partition/%<partition-name>s/shared-vlan"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting shared-vlan') do
            client.delete(url)
        end
    end
end