resource_name :a10_netflow_monitor_destination

property :a10_name, String, name_property: true
property :ip_cfg, Hash
property :service_group, String
property :uuid, String
property :ipv6_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/%<name>s/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s/destination"
    ip_cfg = new_resource.ip_cfg
    service_group = new_resource.service_group
    uuid = new_resource.uuid
    ipv6_cfg = new_resource.ipv6_cfg

    params = { "destination": {"ip-cfg": ip_cfg,
        "service-group": service_group,
        "uuid": uuid,
        "ipv6-cfg": ipv6_cfg,} }

    params[:"destination"].each do |k, v|
        if not v 
            params[:"destination"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating destination') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/destination"
    ip_cfg = new_resource.ip_cfg
    service_group = new_resource.service_group
    uuid = new_resource.uuid
    ipv6_cfg = new_resource.ipv6_cfg

    params = { "destination": {"ip-cfg": ip_cfg,
        "service-group": service_group,
        "uuid": uuid,
        "ipv6-cfg": ipv6_cfg,} }

    params[:"destination"].each do |k, v|
        if not v
            params[:"destination"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["destination"].each do |k, v|
        if v != params[:"destination"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating destination') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/destination"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting destination') do
            client.delete(url)
        end
    end
end