resource_name :a10_fw_template_logging_source_address

property :a10_name, String, name_property: true
property :ip, String
property :uuid, String
property :ipv6, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/template/logging/%<name>s/"
    get_url = "/axapi/v3/fw/template/logging/%<name>s/source-address"
    ip = new_resource.ip
    uuid = new_resource.uuid
    ipv6 = new_resource.ipv6

    params = { "source-address": {"ip": ip,
        "uuid": uuid,
        "ipv6": ipv6,} }

    params[:"source-address"].each do |k, v|
        if not v 
            params[:"source-address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating source-address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/template/logging/%<name>s/source-address"
    ip = new_resource.ip
    uuid = new_resource.uuid
    ipv6 = new_resource.ipv6

    params = { "source-address": {"ip": ip,
        "uuid": uuid,
        "ipv6": ipv6,} }

    params[:"source-address"].each do |k, v|
        if not v
            params[:"source-address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["source-address"].each do |k, v|
        if v != params[:"source-address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating source-address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/template/logging/%<name>s/source-address"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting source-address') do
            client.delete(url)
        end
    end
end