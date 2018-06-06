resource_name :a10_enable_management_service_ping_acl_v6

property :a10_name, String, name_property: true
property :tunnel_cfg, Array
property :management, [true, false]
property :uuid, String
property :acl_name, String,required: true
property :user_tag, String
property :ve_cfg, Array
property :all_data_intf, [true, false]
property :eth_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/enable-management/service/ping/acl-v6/"
    get_url = "/axapi/v3/enable-management/service/ping/acl-v6/%<acl-name>s"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    acl_name = new_resource.acl_name
    user_tag = new_resource.user_tag
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    eth_cfg = new_resource.eth_cfg

    params = { "acl-v6": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "acl-name": acl_name,
        "user-tag": user_tag,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "eth-cfg": eth_cfg,} }

    params[:"acl-v6"].each do |k, v|
        if not v 
            params[:"acl-v6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating acl-v6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/ping/acl-v6/%<acl-name>s"
    tunnel_cfg = new_resource.tunnel_cfg
    management = new_resource.management
    uuid = new_resource.uuid
    acl_name = new_resource.acl_name
    user_tag = new_resource.user_tag
    ve_cfg = new_resource.ve_cfg
    all_data_intf = new_resource.all_data_intf
    eth_cfg = new_resource.eth_cfg

    params = { "acl-v6": {"tunnel-cfg": tunnel_cfg,
        "management": management,
        "uuid": uuid,
        "acl-name": acl_name,
        "user-tag": user_tag,
        "ve-cfg": ve_cfg,
        "all-data-intf": all_data_intf,
        "eth-cfg": eth_cfg,} }

    params[:"acl-v6"].each do |k, v|
        if not v
            params[:"acl-v6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["acl-v6"].each do |k, v|
        if v != params[:"acl-v6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating acl-v6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/enable-management/service/ping/acl-v6/%<acl-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting acl-v6') do
            client.delete(url)
        end
    end
end