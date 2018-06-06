resource_name :a10_gslb_zone_service_dns_naptr_record

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :naptr_target, String,required: true
property :service_proto, String,required: true
property :flag, String,required: true
property :preference, Integer
property :ttl, Integer
property :regexp, [true, false]
property :order, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-naptr-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-naptr-record/%<naptr-target>s+%<service-proto>s+%<flag>s"
    sampling_enable = new_resource.sampling_enable
    naptr_target = new_resource.naptr_target
    service_proto = new_resource.service_proto
    flag = new_resource.flag
    preference = new_resource.preference
    ttl = new_resource.ttl
    regexp = new_resource.regexp
    order = new_resource.order
    uuid = new_resource.uuid

    params = { "dns-naptr-record": {"sampling-enable": sampling_enable,
        "naptr-target": naptr_target,
        "service-proto": service_proto,
        "flag": flag,
        "preference": preference,
        "ttl": ttl,
        "regexp": regexp,
        "order": order,
        "uuid": uuid,} }

    params[:"dns-naptr-record"].each do |k, v|
        if not v 
            params[:"dns-naptr-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-naptr-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-naptr-record/%<naptr-target>s+%<service-proto>s+%<flag>s"
    sampling_enable = new_resource.sampling_enable
    naptr_target = new_resource.naptr_target
    service_proto = new_resource.service_proto
    flag = new_resource.flag
    preference = new_resource.preference
    ttl = new_resource.ttl
    regexp = new_resource.regexp
    order = new_resource.order
    uuid = new_resource.uuid

    params = { "dns-naptr-record": {"sampling-enable": sampling_enable,
        "naptr-target": naptr_target,
        "service-proto": service_proto,
        "flag": flag,
        "preference": preference,
        "ttl": ttl,
        "regexp": regexp,
        "order": order,
        "uuid": uuid,} }

    params[:"dns-naptr-record"].each do |k, v|
        if not v
            params[:"dns-naptr-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-naptr-record"].each do |k, v|
        if v != params[:"dns-naptr-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-naptr-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-naptr-record/%<naptr-target>s+%<service-proto>s+%<flag>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-naptr-record') do
            client.delete(url)
        end
    end
end