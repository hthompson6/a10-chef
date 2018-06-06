resource_name :a10_aam_authentication_service_group

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :protocol, ['tcp','udp']
property :uuid, String
property :user_tag, String
property :lb_method, ['round-robin']
property :sampling_enable, Array
property :member_list, Array
property :health_check, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/service-group/"
    get_url = "/axapi/v3/aam/authentication/service-group/%<name>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    lb_method = new_resource.lb_method
    sampling_enable = new_resource.sampling_enable
    member_list = new_resource.member_list
    health_check = new_resource.health_check
    a10_name = new_resource.a10_name

    params = { "service-group": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "uuid": uuid,
        "user-tag": user_tag,
        "lb-method": lb_method,
        "sampling-enable": sampling_enable,
        "member-list": member_list,
        "health-check": health_check,
        "name": a10_name,} }

    params[:"service-group"].each do |k, v|
        if not v 
            params[:"service-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/service-group/%<name>s"
    health_check_disable = new_resource.health_check_disable
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    lb_method = new_resource.lb_method
    sampling_enable = new_resource.sampling_enable
    member_list = new_resource.member_list
    health_check = new_resource.health_check
    a10_name = new_resource.a10_name

    params = { "service-group": {"health-check-disable": health_check_disable,
        "protocol": protocol,
        "uuid": uuid,
        "user-tag": user_tag,
        "lb-method": lb_method,
        "sampling-enable": sampling_enable,
        "member-list": member_list,
        "health-check": health_check,
        "name": a10_name,} }

    params[:"service-group"].each do |k, v|
        if not v
            params[:"service-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-group"].each do |k, v|
        if v != params[:"service-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/service-group/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-group') do
            client.delete(url)
        end
    end
end