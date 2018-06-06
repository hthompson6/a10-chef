resource_name :a10_router_isis

property :a10_name, String, name_property: true
property :domain_password_cfg, Hash
property :max_lsp_lifetime, Integer
property :tag, String,required: true
property :lsp_refresh_interval, Integer
property :set_overload_bit_cfg, Hash
property :net_list, Array
property :uuid, String
property :bfd, ['all-interfaces']
property :metric_style_list, Array
property :authentication, Hash
property :ignore_lsp_errors, [true, false]
property :protocol_list, Array
property :log_adjacency_changes_cfg, Hash
property :spf_interval_exp_list, Array
property :passive_interface_list, Array
property :summary_address_list, Array
property :adjacency_check, [true, false]
property :default_information, ['originate']
property :address_family, Hash
property :redistribute, Hash
property :ha_standby_extra_cost, Array
property :lsp_gen_interval_list, Array
property :is_type, ['level-1','level-1-2','level-2-only']
property :user_tag, String
property :distance_list, Array
property :area_password_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/isis/"
    get_url = "/axapi/v3/router/isis/%<tag>s"
    domain_password_cfg = new_resource.domain_password_cfg
    max_lsp_lifetime = new_resource.max_lsp_lifetime
    tag = new_resource.tag
    lsp_refresh_interval = new_resource.lsp_refresh_interval
    set_overload_bit_cfg = new_resource.set_overload_bit_cfg
    net_list = new_resource.net_list
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    metric_style_list = new_resource.metric_style_list
    authentication = new_resource.authentication
    ignore_lsp_errors = new_resource.ignore_lsp_errors
    protocol_list = new_resource.protocol_list
    log_adjacency_changes_cfg = new_resource.log_adjacency_changes_cfg
    spf_interval_exp_list = new_resource.spf_interval_exp_list
    passive_interface_list = new_resource.passive_interface_list
    summary_address_list = new_resource.summary_address_list
    adjacency_check = new_resource.adjacency_check
    default_information = new_resource.default_information
    address_family = new_resource.address_family
    redistribute = new_resource.redistribute
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost
    lsp_gen_interval_list = new_resource.lsp_gen_interval_list
    is_type = new_resource.is_type
    user_tag = new_resource.user_tag
    distance_list = new_resource.distance_list
    area_password_cfg = new_resource.area_password_cfg

    params = { "isis": {"domain-password-cfg": domain_password_cfg,
        "max-lsp-lifetime": max_lsp_lifetime,
        "tag": tag,
        "lsp-refresh-interval": lsp_refresh_interval,
        "set-overload-bit-cfg": set_overload_bit_cfg,
        "net-list": net_list,
        "uuid": uuid,
        "bfd": bfd,
        "metric-style-list": metric_style_list,
        "authentication": authentication,
        "ignore-lsp-errors": ignore_lsp_errors,
        "protocol-list": protocol_list,
        "log-adjacency-changes-cfg": log_adjacency_changes_cfg,
        "spf-interval-exp-list": spf_interval_exp_list,
        "passive-interface-list": passive_interface_list,
        "summary-address-list": summary_address_list,
        "adjacency-check": adjacency_check,
        "default-information": default_information,
        "address-family": address_family,
        "redistribute": redistribute,
        "ha-standby-extra-cost": ha_standby_extra_cost,
        "lsp-gen-interval-list": lsp_gen_interval_list,
        "is-type": is_type,
        "user-tag": user_tag,
        "distance-list": distance_list,
        "area-password-cfg": area_password_cfg,} }

    params[:"isis"].each do |k, v|
        if not v 
            params[:"isis"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating isis') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/isis/%<tag>s"
    domain_password_cfg = new_resource.domain_password_cfg
    max_lsp_lifetime = new_resource.max_lsp_lifetime
    tag = new_resource.tag
    lsp_refresh_interval = new_resource.lsp_refresh_interval
    set_overload_bit_cfg = new_resource.set_overload_bit_cfg
    net_list = new_resource.net_list
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    metric_style_list = new_resource.metric_style_list
    authentication = new_resource.authentication
    ignore_lsp_errors = new_resource.ignore_lsp_errors
    protocol_list = new_resource.protocol_list
    log_adjacency_changes_cfg = new_resource.log_adjacency_changes_cfg
    spf_interval_exp_list = new_resource.spf_interval_exp_list
    passive_interface_list = new_resource.passive_interface_list
    summary_address_list = new_resource.summary_address_list
    adjacency_check = new_resource.adjacency_check
    default_information = new_resource.default_information
    address_family = new_resource.address_family
    redistribute = new_resource.redistribute
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost
    lsp_gen_interval_list = new_resource.lsp_gen_interval_list
    is_type = new_resource.is_type
    user_tag = new_resource.user_tag
    distance_list = new_resource.distance_list
    area_password_cfg = new_resource.area_password_cfg

    params = { "isis": {"domain-password-cfg": domain_password_cfg,
        "max-lsp-lifetime": max_lsp_lifetime,
        "tag": tag,
        "lsp-refresh-interval": lsp_refresh_interval,
        "set-overload-bit-cfg": set_overload_bit_cfg,
        "net-list": net_list,
        "uuid": uuid,
        "bfd": bfd,
        "metric-style-list": metric_style_list,
        "authentication": authentication,
        "ignore-lsp-errors": ignore_lsp_errors,
        "protocol-list": protocol_list,
        "log-adjacency-changes-cfg": log_adjacency_changes_cfg,
        "spf-interval-exp-list": spf_interval_exp_list,
        "passive-interface-list": passive_interface_list,
        "summary-address-list": summary_address_list,
        "adjacency-check": adjacency_check,
        "default-information": default_information,
        "address-family": address_family,
        "redistribute": redistribute,
        "ha-standby-extra-cost": ha_standby_extra_cost,
        "lsp-gen-interval-list": lsp_gen_interval_list,
        "is-type": is_type,
        "user-tag": user_tag,
        "distance-list": distance_list,
        "area-password-cfg": area_password_cfg,} }

    params[:"isis"].each do |k, v|
        if not v
            params[:"isis"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["isis"].each do |k, v|
        if v != params[:"isis"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating isis') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/isis/%<tag>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting isis') do
            client.delete(url)
        end
    end
end