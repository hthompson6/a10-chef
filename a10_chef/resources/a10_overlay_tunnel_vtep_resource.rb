resource_name :a10_overlay_tunnel_vtep

property :a10_name, String, name_property: true
property :uuid, String
property :user_tag, String
property :destination_ip_address_list, Array
property :encap, ['nvgre','vxlan']
property :host_list, Array
property :id, Integer,required: true
property :source_ip_address, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-tunnel/vtep/"
    get_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    destination_ip_address_list = new_resource.destination_ip_address_list
    encap = new_resource.encap
    host_list = new_resource.host_list
    id = new_resource.id
    source_ip_address = new_resource.source_ip_address

    params = { "vtep": {"uuid": uuid,
        "user-tag": user_tag,
        "destination-ip-address-list": destination_ip_address_list,
        "encap": encap,
        "host-list": host_list,
        "id": id,
        "source-ip-address": source_ip_address,} }

    params[:"vtep"].each do |k, v|
        if not v 
            params[:"vtep"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vtep') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    destination_ip_address_list = new_resource.destination_ip_address_list
    encap = new_resource.encap
    host_list = new_resource.host_list
    id = new_resource.id
    source_ip_address = new_resource.source_ip_address

    params = { "vtep": {"uuid": uuid,
        "user-tag": user_tag,
        "destination-ip-address-list": destination_ip_address_list,
        "encap": encap,
        "host-list": host_list,
        "id": id,
        "source-ip-address": source_ip_address,} }

    params[:"vtep"].each do |k, v|
        if not v
            params[:"vtep"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vtep"].each do |k, v|
        if v != params[:"vtep"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vtep') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vtep') do
            client.delete(url)
        end
    end
end