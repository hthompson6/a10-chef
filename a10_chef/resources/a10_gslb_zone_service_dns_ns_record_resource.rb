resource_name :a10_gslb_zone_service_dns_ns_record

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :ns_name, String,required: true
property :uuid, String
property :ttl, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ns-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ns-record/%<ns-name>s"
    sampling_enable = new_resource.sampling_enable
    ns_name = new_resource.ns_name
    uuid = new_resource.uuid
    ttl = new_resource.ttl

    params = { "dns-ns-record": {"sampling-enable": sampling_enable,
        "ns-name": ns_name,
        "uuid": uuid,
        "ttl": ttl,} }

    params[:"dns-ns-record"].each do |k, v|
        if not v 
            params[:"dns-ns-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-ns-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ns-record/%<ns-name>s"
    sampling_enable = new_resource.sampling_enable
    ns_name = new_resource.ns_name
    uuid = new_resource.uuid
    ttl = new_resource.ttl

    params = { "dns-ns-record": {"sampling-enable": sampling_enable,
        "ns-name": ns_name,
        "uuid": uuid,
        "ttl": ttl,} }

    params[:"dns-ns-record"].each do |k, v|
        if not v
            params[:"dns-ns-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-ns-record"].each do |k, v|
        if v != params[:"dns-ns-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-ns-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ns-record/%<ns-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-ns-record') do
            client.delete(url)
        end
    end
end