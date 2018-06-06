resource_name :a10_gslb_zone_service_dns_record

property :a10_name, String, name_property: true
property :ntype, Integer,required: true
property :data, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-record/%<type>s"
    ntype = new_resource.ntype
    data = new_resource.data
    uuid = new_resource.uuid

    params = { "dns-record": {"type": ntype,
        "data": data,
        "uuid": uuid,} }

    params[:"dns-record"].each do |k, v|
        if not v 
            params[:"dns-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-record/%<type>s"
    ntype = new_resource.ntype
    data = new_resource.data
    uuid = new_resource.uuid

    params = { "dns-record": {"type": ntype,
        "data": data,
        "uuid": uuid,} }

    params[:"dns-record"].each do |k, v|
        if not v
            params[:"dns-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-record"].each do |k, v|
        if v != params[:"dns-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-record/%<type>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-record') do
            client.delete(url)
        end
    end
end