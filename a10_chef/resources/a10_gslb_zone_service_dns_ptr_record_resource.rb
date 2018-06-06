resource_name :a10_gslb_zone_service_dns_ptr_record

property :a10_name, String, name_property: true
property :ptr_name, String,required: true
property :ttl, Integer
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ptr-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ptr-record/%<ptr-name>s"
    ptr_name = new_resource.ptr_name
    ttl = new_resource.ttl
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "dns-ptr-record": {"ptr-name": ptr_name,
        "ttl": ttl,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"dns-ptr-record"].each do |k, v|
        if not v 
            params[:"dns-ptr-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-ptr-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ptr-record/%<ptr-name>s"
    ptr_name = new_resource.ptr_name
    ttl = new_resource.ttl
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "dns-ptr-record": {"ptr-name": ptr_name,
        "ttl": ttl,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"dns-ptr-record"].each do |k, v|
        if not v
            params[:"dns-ptr-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-ptr-record"].each do |k, v|
        if v != params[:"dns-ptr-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-ptr-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-ptr-record/%<ptr-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-ptr-record') do
            client.delete(url)
        end
    end
end