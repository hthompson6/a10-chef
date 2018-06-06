resource_name :a10_vrrp_a_restart_port_list

property :a10_name, String, name_property: true
property :vrid_list, Array
property :ethernet_cfg, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/"
    get_url = "/axapi/v3/vrrp-a/restart-port-list"
    vrid_list = new_resource.vrid_list
    ethernet_cfg = new_resource.ethernet_cfg
    uuid = new_resource.uuid

    params = { "restart-port-list": {"vrid-list": vrid_list,
        "ethernet-cfg": ethernet_cfg,
        "uuid": uuid,} }

    params[:"restart-port-list"].each do |k, v|
        if not v 
            params[:"restart-port-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating restart-port-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/restart-port-list"
    vrid_list = new_resource.vrid_list
    ethernet_cfg = new_resource.ethernet_cfg
    uuid = new_resource.uuid

    params = { "restart-port-list": {"vrid-list": vrid_list,
        "ethernet-cfg": ethernet_cfg,
        "uuid": uuid,} }

    params[:"restart-port-list"].each do |k, v|
        if not v
            params[:"restart-port-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["restart-port-list"].each do |k, v|
        if v != params[:"restart-port-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating restart-port-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/restart-port-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting restart-port-list') do
            client.delete(url)
        end
    end
end