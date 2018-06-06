resource_name :a10_zone_interface

property :a10_name, String, name_property: true
property :tunnel_list, Array
property :trunk_list, Array
property :ve_list, Array
property :ethernet_list, Array
property :lif_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/zone/%<name>s/"
    get_url = "/axapi/v3/zone/%<name>s/interface"
    tunnel_list = new_resource.tunnel_list
    trunk_list = new_resource.trunk_list
    ve_list = new_resource.ve_list
    ethernet_list = new_resource.ethernet_list
    lif_list = new_resource.lif_list
    uuid = new_resource.uuid

    params = { "interface": {"tunnel-list": tunnel_list,
        "trunk-list": trunk_list,
        "ve-list": ve_list,
        "ethernet-list": ethernet_list,
        "lif-list": lif_list,
        "uuid": uuid,} }

    params[:"interface"].each do |k, v|
        if not v 
            params[:"interface"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating interface') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/interface"
    tunnel_list = new_resource.tunnel_list
    trunk_list = new_resource.trunk_list
    ve_list = new_resource.ve_list
    ethernet_list = new_resource.ethernet_list
    lif_list = new_resource.lif_list
    uuid = new_resource.uuid

    params = { "interface": {"tunnel-list": tunnel_list,
        "trunk-list": trunk_list,
        "ve-list": ve_list,
        "ethernet-list": ethernet_list,
        "lif-list": lif_list,
        "uuid": uuid,} }

    params[:"interface"].each do |k, v|
        if not v
            params[:"interface"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["interface"].each do |k, v|
        if v != params[:"interface"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating interface') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s/interface"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting interface') do
            client.delete(url)
        end
    end
end