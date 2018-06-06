resource_name :a10_system_resource_accounting_template_app_resources

property :a10_name, String, name_property: true
property :gslb_site_cfg, Hash
property :gslb_policy_cfg, Hash
property :gslb_service_cfg, Hash
property :gslb_geo_location_cfg, Hash
property :uuid, String
property :real_server_cfg, Hash
property :gslb_ip_list_cfg, Hash
property :gslb_template_cfg, Hash
property :gslb_zone_cfg, Hash
property :gslb_device_cfg, Hash
property :virtual_server_cfg, Hash
property :real_port_cfg, Hash
property :health_monitor_cfg, Hash
property :threshold, Integer
property :gslb_svc_group_cfg, Hash
property :service_group_cfg, Hash
property :gslb_service_port_cfg, Hash
property :gslb_service_ip_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/resource-accounting/template/%<name>s/"
    get_url = "/axapi/v3/system/resource-accounting/template/%<name>s/app-resources"
    gslb_site_cfg = new_resource.gslb_site_cfg
    gslb_policy_cfg = new_resource.gslb_policy_cfg
    gslb_service_cfg = new_resource.gslb_service_cfg
    gslb_geo_location_cfg = new_resource.gslb_geo_location_cfg
    uuid = new_resource.uuid
    real_server_cfg = new_resource.real_server_cfg
    gslb_ip_list_cfg = new_resource.gslb_ip_list_cfg
    gslb_template_cfg = new_resource.gslb_template_cfg
    gslb_zone_cfg = new_resource.gslb_zone_cfg
    gslb_device_cfg = new_resource.gslb_device_cfg
    virtual_server_cfg = new_resource.virtual_server_cfg
    real_port_cfg = new_resource.real_port_cfg
    health_monitor_cfg = new_resource.health_monitor_cfg
    threshold = new_resource.threshold
    gslb_svc_group_cfg = new_resource.gslb_svc_group_cfg
    service_group_cfg = new_resource.service_group_cfg
    gslb_service_port_cfg = new_resource.gslb_service_port_cfg
    gslb_service_ip_cfg = new_resource.gslb_service_ip_cfg

    params = { "app-resources": {"gslb-site-cfg": gslb_site_cfg,
        "gslb-policy-cfg": gslb_policy_cfg,
        "gslb-service-cfg": gslb_service_cfg,
        "gslb-geo-location-cfg": gslb_geo_location_cfg,
        "uuid": uuid,
        "real-server-cfg": real_server_cfg,
        "gslb-ip-list-cfg": gslb_ip_list_cfg,
        "gslb-template-cfg": gslb_template_cfg,
        "gslb-zone-cfg": gslb_zone_cfg,
        "gslb-device-cfg": gslb_device_cfg,
        "virtual-server-cfg": virtual_server_cfg,
        "real-port-cfg": real_port_cfg,
        "health-monitor-cfg": health_monitor_cfg,
        "threshold": threshold,
        "gslb-svc-group-cfg": gslb_svc_group_cfg,
        "service-group-cfg": service_group_cfg,
        "gslb-service-port-cfg": gslb_service_port_cfg,
        "gslb-service-ip-cfg": gslb_service_ip_cfg,} }

    params[:"app-resources"].each do |k, v|
        if not v 
            params[:"app-resources"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating app-resources') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/app-resources"
    gslb_site_cfg = new_resource.gslb_site_cfg
    gslb_policy_cfg = new_resource.gslb_policy_cfg
    gslb_service_cfg = new_resource.gslb_service_cfg
    gslb_geo_location_cfg = new_resource.gslb_geo_location_cfg
    uuid = new_resource.uuid
    real_server_cfg = new_resource.real_server_cfg
    gslb_ip_list_cfg = new_resource.gslb_ip_list_cfg
    gslb_template_cfg = new_resource.gslb_template_cfg
    gslb_zone_cfg = new_resource.gslb_zone_cfg
    gslb_device_cfg = new_resource.gslb_device_cfg
    virtual_server_cfg = new_resource.virtual_server_cfg
    real_port_cfg = new_resource.real_port_cfg
    health_monitor_cfg = new_resource.health_monitor_cfg
    threshold = new_resource.threshold
    gslb_svc_group_cfg = new_resource.gslb_svc_group_cfg
    service_group_cfg = new_resource.service_group_cfg
    gslb_service_port_cfg = new_resource.gslb_service_port_cfg
    gslb_service_ip_cfg = new_resource.gslb_service_ip_cfg

    params = { "app-resources": {"gslb-site-cfg": gslb_site_cfg,
        "gslb-policy-cfg": gslb_policy_cfg,
        "gslb-service-cfg": gslb_service_cfg,
        "gslb-geo-location-cfg": gslb_geo_location_cfg,
        "uuid": uuid,
        "real-server-cfg": real_server_cfg,
        "gslb-ip-list-cfg": gslb_ip_list_cfg,
        "gslb-template-cfg": gslb_template_cfg,
        "gslb-zone-cfg": gslb_zone_cfg,
        "gslb-device-cfg": gslb_device_cfg,
        "virtual-server-cfg": virtual_server_cfg,
        "real-port-cfg": real_port_cfg,
        "health-monitor-cfg": health_monitor_cfg,
        "threshold": threshold,
        "gslb-svc-group-cfg": gslb_svc_group_cfg,
        "service-group-cfg": service_group_cfg,
        "gslb-service-port-cfg": gslb_service_port_cfg,
        "gslb-service-ip-cfg": gslb_service_ip_cfg,} }

    params[:"app-resources"].each do |k, v|
        if not v
            params[:"app-resources"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["app-resources"].each do |k, v|
        if v != params[:"app-resources"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating app-resources') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/app-resources"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting app-resources') do
            client.delete(url)
        end
    end
end