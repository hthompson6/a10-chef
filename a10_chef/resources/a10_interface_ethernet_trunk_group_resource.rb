resource_name :a10_interface_ethernet_trunk_group

property :a10_name, String, name_property: true
property :uuid, String
property :trunk_number, Integer,required: true
property :user_tag, String
property :udld_timeout_cfg, Hash
property :mode, ['active','passive']
property :timeout, ['long','short']
property :ntype, ['static','lacp','lacp-udld']
property :admin_key, Integer
property :port_priority, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/%<ifnum>s/trunk-group/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s/trunk-group/%<trunk-number>s"
    uuid = new_resource.uuid
    trunk_number = new_resource.trunk_number
    user_tag = new_resource.user_tag
    udld_timeout_cfg = new_resource.udld_timeout_cfg
    mode = new_resource.mode
    timeout = new_resource.timeout
    ntype = new_resource.ntype
    admin_key = new_resource.admin_key
    port_priority = new_resource.port_priority

    params = { "trunk-group": {"uuid": uuid,
        "trunk-number": trunk_number,
        "user-tag": user_tag,
        "udld-timeout-cfg": udld_timeout_cfg,
        "mode": mode,
        "timeout": timeout,
        "type": ntype,
        "admin-key": admin_key,
        "port-priority": port_priority,} }

    params[:"trunk-group"].each do |k, v|
        if not v 
            params[:"trunk-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trunk-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/trunk-group/%<trunk-number>s"
    uuid = new_resource.uuid
    trunk_number = new_resource.trunk_number
    user_tag = new_resource.user_tag
    udld_timeout_cfg = new_resource.udld_timeout_cfg
    mode = new_resource.mode
    timeout = new_resource.timeout
    ntype = new_resource.ntype
    admin_key = new_resource.admin_key
    port_priority = new_resource.port_priority

    params = { "trunk-group": {"uuid": uuid,
        "trunk-number": trunk_number,
        "user-tag": user_tag,
        "udld-timeout-cfg": udld_timeout_cfg,
        "mode": mode,
        "timeout": timeout,
        "type": ntype,
        "admin-key": admin_key,
        "port-priority": port_priority,} }

    params[:"trunk-group"].each do |k, v|
        if not v
            params[:"trunk-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trunk-group"].each do |k, v|
        if v != params[:"trunk-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trunk-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/trunk-group/%<trunk-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trunk-group') do
            client.delete(url)
        end
    end
end