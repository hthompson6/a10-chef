resource_name :a10_ip_dns_suffix

property :a10_name, String, name_property: true
property :domain_name, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/dns/"
    get_url = "/axapi/v3/ip/dns/suffix"
    domain_name = new_resource.domain_name
    uuid = new_resource.uuid

    params = { "suffix": {"domain-name": domain_name,
        "uuid": uuid,} }

    params[:"suffix"].each do |k, v|
        if not v 
            params[:"suffix"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating suffix') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/dns/suffix"
    domain_name = new_resource.domain_name
    uuid = new_resource.uuid

    params = { "suffix": {"domain-name": domain_name,
        "uuid": uuid,} }

    params[:"suffix"].each do |k, v|
        if not v
            params[:"suffix"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["suffix"].each do |k, v|
        if v != params[:"suffix"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating suffix') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/dns/suffix"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting suffix') do
            client.delete(url)
        end
    end
end