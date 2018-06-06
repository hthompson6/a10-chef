resource_name :a10_gslb_zone_service

property :a10_name, String, name_property: true
property :dns_a_record, Hash
property :forward_type, ['both','query','response']
property :uuid, String
property :health_check_port, Array
property :dns_txt_record_list, Array
property :service_port, Integer,required: true
property :dns_mx_record_list, Array
property :dns_record_list, Array
property :user_tag, String
property :dns_ns_record_list, Array
property :health_check_gateway, ['enable','disable']
property :sampling_enable, Array
property :disable, [true, false]
property :dns_srv_record_list, Array
property :service_name, String,required: true
property :policy, String
property :dns_ptr_record_list, Array
property :dns_cname_record_list, Array
property :a10_action, ['drop','forward','ignore','reject']
property :geo_location_list, Array
property :dns_naptr_record_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s"
    dns_a_record = new_resource.dns_a_record
    forward_type = new_resource.forward_type
    uuid = new_resource.uuid
    health_check_port = new_resource.health_check_port
    dns_txt_record_list = new_resource.dns_txt_record_list
    service_port = new_resource.service_port
    dns_mx_record_list = new_resource.dns_mx_record_list
    dns_record_list = new_resource.dns_record_list
    user_tag = new_resource.user_tag
    dns_ns_record_list = new_resource.dns_ns_record_list
    health_check_gateway = new_resource.health_check_gateway
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    dns_srv_record_list = new_resource.dns_srv_record_list
    service_name = new_resource.service_name
    policy = new_resource.policy
    dns_ptr_record_list = new_resource.dns_ptr_record_list
    dns_cname_record_list = new_resource.dns_cname_record_list
    a10_name = new_resource.a10_name
    geo_location_list = new_resource.geo_location_list
    dns_naptr_record_list = new_resource.dns_naptr_record_list

    params = { "service": {"dns-a-record": dns_a_record,
        "forward-type": forward_type,
        "uuid": uuid,
        "health-check-port": health_check_port,
        "dns-txt-record-list": dns_txt_record_list,
        "service-port": service_port,
        "dns-mx-record-list": dns_mx_record_list,
        "dns-record-list": dns_record_list,
        "user-tag": user_tag,
        "dns-ns-record-list": dns_ns_record_list,
        "health-check-gateway": health_check_gateway,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "dns-srv-record-list": dns_srv_record_list,
        "service-name": service_name,
        "policy": policy,
        "dns-ptr-record-list": dns_ptr_record_list,
        "dns-cname-record-list": dns_cname_record_list,
        "action": a10_action,
        "geo-location-list": geo_location_list,
        "dns-naptr-record-list": dns_naptr_record_list,} }

    params[:"service"].each do |k, v|
        if not v 
            params[:"service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s"
    dns_a_record = new_resource.dns_a_record
    forward_type = new_resource.forward_type
    uuid = new_resource.uuid
    health_check_port = new_resource.health_check_port
    dns_txt_record_list = new_resource.dns_txt_record_list
    service_port = new_resource.service_port
    dns_mx_record_list = new_resource.dns_mx_record_list
    dns_record_list = new_resource.dns_record_list
    user_tag = new_resource.user_tag
    dns_ns_record_list = new_resource.dns_ns_record_list
    health_check_gateway = new_resource.health_check_gateway
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    dns_srv_record_list = new_resource.dns_srv_record_list
    service_name = new_resource.service_name
    policy = new_resource.policy
    dns_ptr_record_list = new_resource.dns_ptr_record_list
    dns_cname_record_list = new_resource.dns_cname_record_list
    a10_name = new_resource.a10_name
    geo_location_list = new_resource.geo_location_list
    dns_naptr_record_list = new_resource.dns_naptr_record_list

    params = { "service": {"dns-a-record": dns_a_record,
        "forward-type": forward_type,
        "uuid": uuid,
        "health-check-port": health_check_port,
        "dns-txt-record-list": dns_txt_record_list,
        "service-port": service_port,
        "dns-mx-record-list": dns_mx_record_list,
        "dns-record-list": dns_record_list,
        "user-tag": user_tag,
        "dns-ns-record-list": dns_ns_record_list,
        "health-check-gateway": health_check_gateway,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "dns-srv-record-list": dns_srv_record_list,
        "service-name": service_name,
        "policy": policy,
        "dns-ptr-record-list": dns_ptr_record_list,
        "dns-cname-record-list": dns_cname_record_list,
        "action": a10_action,
        "geo-location-list": geo_location_list,
        "dns-naptr-record-list": dns_naptr_record_list,} }

    params[:"service"].each do |k, v|
        if not v
            params[:"service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service"].each do |k, v|
        if v != params[:"service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service') do
            client.delete(url)
        end
    end
end