resource_name :a10_gslb_zone_service_dns_txt_record

property :a10_name, String, name_property: true
property :record_name, String,required: true
property :ttl, Integer
property :sampling_enable, Array
property :uuid, String
property :txt_data, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-txt-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-txt-record/%<record-name>s"
    record_name = new_resource.record_name
    ttl = new_resource.ttl
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    txt_data = new_resource.txt_data

    params = { "dns-txt-record": {"record-name": record_name,
        "ttl": ttl,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "txt-data": txt_data,} }

    params[:"dns-txt-record"].each do |k, v|
        if not v 
            params[:"dns-txt-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-txt-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-txt-record/%<record-name>s"
    record_name = new_resource.record_name
    ttl = new_resource.ttl
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    txt_data = new_resource.txt_data

    params = { "dns-txt-record": {"record-name": record_name,
        "ttl": ttl,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "txt-data": txt_data,} }

    params[:"dns-txt-record"].each do |k, v|
        if not v
            params[:"dns-txt-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-txt-record"].each do |k, v|
        if v != params[:"dns-txt-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-txt-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-txt-record/%<record-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-txt-record') do
            client.delete(url)
        end
    end
end