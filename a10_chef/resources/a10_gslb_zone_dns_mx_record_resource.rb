resource_name :a10_gslb_zone_dns_mx_record

property :a10_name, String, name_property: true
property :priority, Integer
property :sampling_enable, Array
property :uuid, String
property :mx_name, String,required: true
property :ttl, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/dns-mx-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/dns-mx-record/%<mx-name>s"
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    mx_name = new_resource.mx_name
    ttl = new_resource.ttl

    params = { "dns-mx-record": {"priority": priority,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "mx-name": mx_name,
        "ttl": ttl,} }

    params[:"dns-mx-record"].each do |k, v|
        if not v 
            params[:"dns-mx-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-mx-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/dns-mx-record/%<mx-name>s"
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    mx_name = new_resource.mx_name
    ttl = new_resource.ttl

    params = { "dns-mx-record": {"priority": priority,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "mx-name": mx_name,
        "ttl": ttl,} }

    params[:"dns-mx-record"].each do |k, v|
        if not v
            params[:"dns-mx-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-mx-record"].each do |k, v|
        if v != params[:"dns-mx-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-mx-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/dns-mx-record/%<mx-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-mx-record') do
            client.delete(url)
        end
    end
end