resource_name :a10_gslb_zone

property :a10_name, String, name_property: true
property :dns_ns_record_list, Array
property :dns_mx_record_list, Array
property :user_tag, String
property :sampling_enable, Array
property :disable, [true, false]
property :template, Hash
property :ttl, Integer
property :policy, String
property :use_server_ttl, [true, false]
property :dns_soa_record, Hash
property :service_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/"
    get_url = "/axapi/v3/gslb/zone/%<name>s"
    a10_name = new_resource.a10_name
    dns_ns_record_list = new_resource.dns_ns_record_list
    dns_mx_record_list = new_resource.dns_mx_record_list
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    template = new_resource.template
    ttl = new_resource.ttl
    policy = new_resource.policy
    use_server_ttl = new_resource.use_server_ttl
    dns_soa_record = new_resource.dns_soa_record
    service_list = new_resource.service_list
    uuid = new_resource.uuid

    params = { "zone": {"name": a10_name,
        "dns-ns-record-list": dns_ns_record_list,
        "dns-mx-record-list": dns_mx_record_list,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "template": template,
        "ttl": ttl,
        "policy": policy,
        "use-server-ttl": use_server_ttl,
        "dns-soa-record": dns_soa_record,
        "service-list": service_list,
        "uuid": uuid,} }

    params[:"zone"].each do |k, v|
        if not v 
            params[:"zone"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating zone') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s"
    a10_name = new_resource.a10_name
    dns_ns_record_list = new_resource.dns_ns_record_list
    dns_mx_record_list = new_resource.dns_mx_record_list
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    template = new_resource.template
    ttl = new_resource.ttl
    policy = new_resource.policy
    use_server_ttl = new_resource.use_server_ttl
    dns_soa_record = new_resource.dns_soa_record
    service_list = new_resource.service_list
    uuid = new_resource.uuid

    params = { "zone": {"name": a10_name,
        "dns-ns-record-list": dns_ns_record_list,
        "dns-mx-record-list": dns_mx_record_list,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "template": template,
        "ttl": ttl,
        "policy": policy,
        "use-server-ttl": use_server_ttl,
        "dns-soa-record": dns_soa_record,
        "service-list": service_list,
        "uuid": uuid,} }

    params[:"zone"].each do |k, v|
        if not v
            params[:"zone"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["zone"].each do |k, v|
        if v != params[:"zone"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating zone') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting zone') do
            client.delete(url)
        end
    end
end