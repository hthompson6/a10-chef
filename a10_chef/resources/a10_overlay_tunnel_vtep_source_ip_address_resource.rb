resource_name :a10_overlay_tunnel_vtep_source_ip_address

property :a10_name, String, name_property: true
property :ip_address, String,required: true
property :uuid, String
property :vni_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/"
    get_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address"
    ip_address = new_resource.ip_address
    uuid = new_resource.uuid
    vni_list = new_resource.vni_list

    params = { "source-ip-address": {"ip-address": ip_address,
        "uuid": uuid,
        "vni-list": vni_list,} }

    params[:"source-ip-address"].each do |k, v|
        if not v 
            params[:"source-ip-address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating source-ip-address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address"
    ip_address = new_resource.ip_address
    uuid = new_resource.uuid
    vni_list = new_resource.vni_list

    params = { "source-ip-address": {"ip-address": ip_address,
        "uuid": uuid,
        "vni-list": vni_list,} }

    params[:"source-ip-address"].each do |k, v|
        if not v
            params[:"source-ip-address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["source-ip-address"].each do |k, v|
        if v != params[:"source-ip-address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating source-ip-address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting source-ip-address') do
            client.delete(url)
        end
    end
end