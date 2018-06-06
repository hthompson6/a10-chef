resource_name :a10_disable_management_service_ping

property :a10_name, String, name_property: true
property :tunnel_cfg, Array
property :management, [true, false]
property :uuid, String
property :ve_cfg, Array
property :all_data_intf, [true, false]
property :eth_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/disable-management/service/"
    get_url = "/axapi/v3/disable-management/service/ping"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    eth_cfg = new_resource.eth_cfg

    params = { "ping": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "eth-cfg": eth_cfg,} }

    params[:"ping"].each do |k, v|
        if not v 
            params[:"ping"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ping') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/disable-management/service/ping"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    eth_cfg = new_resource.eth_cfg

    params = { "ping": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "eth-cfg": eth_cfg,} }

    params[:"ping"].each do |k, v|
        if not v
            params[:"ping"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ping"].each do |k, v|
        if v != params[:"ping"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ping') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/disable-management/service/ping"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ping') do
            client.delete(url)
        end
    end
end