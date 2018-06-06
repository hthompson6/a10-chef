resource_name :a10_dnssec_dnskey

property :a10_name, String, name_property: true
property :key_delete, [true, false]
property :zone_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/dnssec/"
    get_url = "/axapi/v3/dnssec/dnskey"
    key_delete = new_resource.key_delete
    zone_name = new_resource.zone_name

    params = { "dnskey": {"key-delete": key_delete,
        "zone-name": zone_name,} }

    params[:"dnskey"].each do |k, v|
        if not v 
            params[:"dnskey"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dnskey') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/dnskey"
    key_delete = new_resource.key_delete
    zone_name = new_resource.zone_name

    params = { "dnskey": {"key-delete": key_delete,
        "zone-name": zone_name,} }

    params[:"dnskey"].each do |k, v|
        if not v
            params[:"dnskey"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dnskey"].each do |k, v|
        if v != params[:"dnskey"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dnskey') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/dnskey"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dnskey') do
            client.delete(url)
        end
    end
end