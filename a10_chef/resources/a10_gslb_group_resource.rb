resource_name :a10_gslb_group

property :a10_name, String, name_property: true
property :config_save, [true, false]
property :enable, [true, false]
property :uuid, String
property :standalone, [true, false]
property :mgmt_interface, [true, false]
property :user_tag, String
property :dns_discover, [true, false]
property :priority, Integer
property :config_anywhere, [true, false]
property :data_interface, [true, false]
property :auto_map_primary, [true, false]
property :learn, [true, false]
property :primary_list, Array
property :auto_map_learn, [true, false]
property :suffix, String
property :config_merge, [true, false]
property :auto_map_smart, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/group/"
    get_url = "/axapi/v3/gslb/group/%<name>s"
    config_save = new_resource.config_save
    enable = new_resource.enable
    uuid = new_resource.uuid
    standalone = new_resource.standalone
    mgmt_interface = new_resource.mgmt_interface
    user_tag = new_resource.user_tag
    dns_discover = new_resource.dns_discover
    priority = new_resource.priority
    config_anywhere = new_resource.config_anywhere
    data_interface = new_resource.data_interface
    auto_map_primary = new_resource.auto_map_primary
    learn = new_resource.learn
    primary_list = new_resource.primary_list
    auto_map_learn = new_resource.auto_map_learn
    suffix = new_resource.suffix
    config_merge = new_resource.config_merge
    auto_map_smart = new_resource.auto_map_smart
    a10_name = new_resource.a10_name

    params = { "group": {"config-save": config_save,
        "enable": enable,
        "uuid": uuid,
        "standalone": standalone,
        "mgmt-interface": mgmt_interface,
        "user-tag": user_tag,
        "dns-discover": dns_discover,
        "priority": priority,
        "config-anywhere": config_anywhere,
        "data-interface": data_interface,
        "auto-map-primary": auto_map_primary,
        "learn": learn,
        "primary-list": primary_list,
        "auto-map-learn": auto_map_learn,
        "suffix": suffix,
        "config-merge": config_merge,
        "auto-map-smart": auto_map_smart,
        "name": a10_name,} }

    params[:"group"].each do |k, v|
        if not v 
            params[:"group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/group/%<name>s"
    config_save = new_resource.config_save
    enable = new_resource.enable
    uuid = new_resource.uuid
    standalone = new_resource.standalone
    mgmt_interface = new_resource.mgmt_interface
    user_tag = new_resource.user_tag
    dns_discover = new_resource.dns_discover
    priority = new_resource.priority
    config_anywhere = new_resource.config_anywhere
    data_interface = new_resource.data_interface
    auto_map_primary = new_resource.auto_map_primary
    learn = new_resource.learn
    primary_list = new_resource.primary_list
    auto_map_learn = new_resource.auto_map_learn
    suffix = new_resource.suffix
    config_merge = new_resource.config_merge
    auto_map_smart = new_resource.auto_map_smart
    a10_name = new_resource.a10_name

    params = { "group": {"config-save": config_save,
        "enable": enable,
        "uuid": uuid,
        "standalone": standalone,
        "mgmt-interface": mgmt_interface,
        "user-tag": user_tag,
        "dns-discover": dns_discover,
        "priority": priority,
        "config-anywhere": config_anywhere,
        "data-interface": data_interface,
        "auto-map-primary": auto_map_primary,
        "learn": learn,
        "primary-list": primary_list,
        "auto-map-learn": auto_map_learn,
        "suffix": suffix,
        "config-merge": config_merge,
        "auto-map-smart": auto_map_smart,
        "name": a10_name,} }

    params[:"group"].each do |k, v|
        if not v
            params[:"group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["group"].each do |k, v|
        if v != params[:"group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/group/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting group') do
            client.delete(url)
        end
    end
end