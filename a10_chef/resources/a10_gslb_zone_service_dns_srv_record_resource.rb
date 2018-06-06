resource_name :a10_gslb_zone_service_dns_srv_record

property :a10_name, String, name_property: true
property :srv_name, String,required: true
property :uuid, String
property :weight, Integer
property :priority, Integer
property :sampling_enable, Array
property :ttl, Integer
property :port, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-srv-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-srv-record/%<srv-name>s+%<port>s"
    srv_name = new_resource.srv_name
    uuid = new_resource.uuid
    weight = new_resource.weight
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    ttl = new_resource.ttl
    port = new_resource.port

    params = { "dns-srv-record": {"srv-name": srv_name,
        "uuid": uuid,
        "weight": weight,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "ttl": ttl,
        "port": port,} }

    params[:"dns-srv-record"].each do |k, v|
        if not v 
            params[:"dns-srv-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-srv-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-srv-record/%<srv-name>s+%<port>s"
    srv_name = new_resource.srv_name
    uuid = new_resource.uuid
    weight = new_resource.weight
    priority = new_resource.priority
    sampling_enable = new_resource.sampling_enable
    ttl = new_resource.ttl
    port = new_resource.port

    params = { "dns-srv-record": {"srv-name": srv_name,
        "uuid": uuid,
        "weight": weight,
        "priority": priority,
        "sampling-enable": sampling_enable,
        "ttl": ttl,
        "port": port,} }

    params[:"dns-srv-record"].each do |k, v|
        if not v
            params[:"dns-srv-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-srv-record"].each do |k, v|
        if v != params[:"dns-srv-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-srv-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-srv-record/%<srv-name>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-srv-record') do
            client.delete(url)
        end
    end
end