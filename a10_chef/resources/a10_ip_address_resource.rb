resource_name :a10_ip_address

property :a10_name, String, name_property: true
property :ip_addr, String
property :ip_mask, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/address"
    ip_addr = new_resource.ip_addr
    ip_mask = new_resource.ip_mask
    uuid = new_resource.uuid

    params = { "address": {"ip-addr": ip_addr,
        "ip-mask": ip_mask,
        "uuid": uuid,} }

    params[:"address"].each do |k, v|
        if not v 
            params[:"address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/address"
    ip_addr = new_resource.ip_addr
    ip_mask = new_resource.ip_mask
    uuid = new_resource.uuid

    params = { "address": {"ip-addr": ip_addr,
        "ip-mask": ip_mask,
        "uuid": uuid,} }

    params[:"address"].each do |k, v|
        if not v
            params[:"address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["address"].each do |k, v|
        if v != params[:"address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/address"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting address') do
            client.delete(url)
        end
    end
end