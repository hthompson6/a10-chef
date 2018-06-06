resource_name :a10_enable_management_service_http

property :a10_name, String, name_property: true
property :tunnel_cfg, Array
property :management, [true, false]
property :uuid, String
property :acl_v6_list, Array
property :ve_cfg, Array
property :all_data_intf, [true, false]
property :acl_v4_list, Array
property :eth_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/enable-management/service/"
    get_url = "/axapi/v3/enable-management/service/http"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    acl_v6_list = new_resource.acl_v6_list
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    acl_v4_list = new_resource.acl_v4_list
    eth_cfg = new_resource.eth_cfg

    params = { "http": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "acl-v6-list": acl_v6_list,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "acl-v4-list": acl_v4_list,
        "eth-cfg": eth_cfg,} }

    params[:"http"].each do |k, v|
        if not v 
            params[:"http"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/http"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    acl_v6_list = new_resource.acl_v6_list
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    acl_v4_list = new_resource.acl_v4_list
    eth_cfg = new_resource.eth_cfg

    params = { "http": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "acl-v6-list": acl_v6_list,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "acl-v4-list": acl_v4_list,
        "eth-cfg": eth_cfg,} }

    params[:"http"].each do |k, v|
        if not v
            params[:"http"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http"].each do |k, v|
        if v != params[:"http"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/http"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http') do
            client.delete(url)
        end
    end
end