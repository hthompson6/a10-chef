resource_name :a10_router_ospf_redistribute

property :a10_name, String, name_property: true
property :redist_list, Array
property :ospf_list, Array
property :uuid, String
property :ip_nat_floating_list, Array
property :vip_list, Array
property :route_map_ip_nat, String
property :ip_nat, [true, false]
property :metric_ip_nat, Integer
property :tag_ip_nat, Integer
property :vip_floating_list, Array
property :metric_type_ip_nat, ['1','2']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ospf/%<process-id>s/"
    get_url = "/axapi/v3/router/ospf/%<process-id>s/redistribute"
    redist_list = new_resource.redist_list
    ospf_list = new_resource.ospf_list
    uuid = new_resource.uuid
    ip_nat_floating_list = new_resource.ip_nat_floating_list
    vip_list = new_resource.vip_list
    route_map_ip_nat = new_resource.route_map_ip_nat
    ip_nat = new_resource.ip_nat
    metric_ip_nat = new_resource.metric_ip_nat
    tag_ip_nat = new_resource.tag_ip_nat
    vip_floating_list = new_resource.vip_floating_list
    metric_type_ip_nat = new_resource.metric_type_ip_nat

    params = { "redistribute": {"redist-list": redist_list,
        "ospf-list": ospf_list,
        "uuid": uuid,
        "ip-nat-floating-list": ip_nat_floating_list,
        "vip-list": vip_list,
        "route-map-ip-nat": route_map_ip_nat,
        "ip-nat": ip_nat,
        "metric-ip-nat": metric_ip_nat,
        "tag-ip-nat": tag_ip_nat,
        "vip-floating-list": vip_floating_list,
        "metric-type-ip-nat": metric_type_ip_nat,} }

    params[:"redistribute"].each do |k, v|
        if not v 
            params[:"redistribute"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating redistribute') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/redistribute"
    redist_list = new_resource.redist_list
    ospf_list = new_resource.ospf_list
    uuid = new_resource.uuid
    ip_nat_floating_list = new_resource.ip_nat_floating_list
    vip_list = new_resource.vip_list
    route_map_ip_nat = new_resource.route_map_ip_nat
    ip_nat = new_resource.ip_nat
    metric_ip_nat = new_resource.metric_ip_nat
    tag_ip_nat = new_resource.tag_ip_nat
    vip_floating_list = new_resource.vip_floating_list
    metric_type_ip_nat = new_resource.metric_type_ip_nat

    params = { "redistribute": {"redist-list": redist_list,
        "ospf-list": ospf_list,
        "uuid": uuid,
        "ip-nat-floating-list": ip_nat_floating_list,
        "vip-list": vip_list,
        "route-map-ip-nat": route_map_ip_nat,
        "ip-nat": ip_nat,
        "metric-ip-nat": metric_ip_nat,
        "tag-ip-nat": tag_ip_nat,
        "vip-floating-list": vip_floating_list,
        "metric-type-ip-nat": metric_type_ip_nat,} }

    params[:"redistribute"].each do |k, v|
        if not v
            params[:"redistribute"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["redistribute"].each do |k, v|
        if v != params[:"redistribute"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating redistribute') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/redistribute"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting redistribute') do
            client.delete(url)
        end
    end
end