resource_name :a10_vrrp_a_l2_inline_peer_ip

property :a10_name, String, name_property: true
property :uuid, String
property :ip_address, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/l2-inline-peer-ip/"
    get_url = "/axapi/v3/vrrp-a/l2-inline-peer-ip/%<ip-address>s"
    uuid = new_resource.uuid
    ip_address = new_resource.ip_address

    params = { "l2-inline-peer-ip": {"uuid": uuid,
        "ip-address": ip_address,} }

    params[:"l2-inline-peer-ip"].each do |k, v|
        if not v 
            params[:"l2-inline-peer-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l2-inline-peer-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/l2-inline-peer-ip/%<ip-address>s"
    uuid = new_resource.uuid
    ip_address = new_resource.ip_address

    params = { "l2-inline-peer-ip": {"uuid": uuid,
        "ip-address": ip_address,} }

    params[:"l2-inline-peer-ip"].each do |k, v|
        if not v
            params[:"l2-inline-peer-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l2-inline-peer-ip"].each do |k, v|
        if v != params[:"l2-inline-peer-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l2-inline-peer-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/l2-inline-peer-ip/%<ip-address>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l2-inline-peer-ip') do
            client.delete(url)
        end
    end
end