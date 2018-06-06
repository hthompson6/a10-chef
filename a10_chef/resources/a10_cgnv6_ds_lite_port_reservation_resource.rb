resource_name :a10_cgnv6_ds_lite_port_reservation

property :a10_name, String, name_property: true
property :nat_end_port, Integer,required: true
property :uuid, String
property :inside, String,required: true
property :tunnel_dest_address, String,required: true
property :inside_start_port, Integer,required: true
property :nat, String,required: true
property :inside_end_port, Integer,required: true
property :nat_start_port, Integer,required: true
property :inside_addr, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/ds-lite/port-reservation/"
    get_url = "/axapi/v3/cgnv6/ds-lite/port-reservation/%<inside>s+%<tunnel-dest-address>s+%<inside-addr>s+%<inside-start-port>s+%<inside-end-port>s+%<nat>s+%<nat-start-port>s+%<nat-end-port>s"
    nat_end_port = new_resource.nat_end_port
    uuid = new_resource.uuid
    inside = new_resource.inside
    tunnel_dest_address = new_resource.tunnel_dest_address
    inside_start_port = new_resource.inside_start_port
    nat = new_resource.nat
    inside_end_port = new_resource.inside_end_port
    nat_start_port = new_resource.nat_start_port
    inside_addr = new_resource.inside_addr

    params = { "port-reservation": {"nat-end-port": nat_end_port,
        "uuid": uuid,
        "inside": inside,
        "tunnel-dest-address": tunnel_dest_address,
        "inside-start-port": inside_start_port,
        "nat": nat,
        "inside-end-port": inside_end_port,
        "nat-start-port": nat_start_port,
        "inside-addr": inside_addr,} }

    params[:"port-reservation"].each do |k, v|
        if not v 
            params[:"port-reservation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port-reservation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ds-lite/port-reservation/%<inside>s+%<tunnel-dest-address>s+%<inside-addr>s+%<inside-start-port>s+%<inside-end-port>s+%<nat>s+%<nat-start-port>s+%<nat-end-port>s"
    nat_end_port = new_resource.nat_end_port
    uuid = new_resource.uuid
    inside = new_resource.inside
    tunnel_dest_address = new_resource.tunnel_dest_address
    inside_start_port = new_resource.inside_start_port
    nat = new_resource.nat
    inside_end_port = new_resource.inside_end_port
    nat_start_port = new_resource.nat_start_port
    inside_addr = new_resource.inside_addr

    params = { "port-reservation": {"nat-end-port": nat_end_port,
        "uuid": uuid,
        "inside": inside,
        "tunnel-dest-address": tunnel_dest_address,
        "inside-start-port": inside_start_port,
        "nat": nat,
        "inside-end-port": inside_end_port,
        "nat-start-port": nat_start_port,
        "inside-addr": inside_addr,} }

    params[:"port-reservation"].each do |k, v|
        if not v
            params[:"port-reservation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port-reservation"].each do |k, v|
        if v != params[:"port-reservation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port-reservation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ds-lite/port-reservation/%<inside>s+%<tunnel-dest-address>s+%<inside-addr>s+%<inside-start-port>s+%<inside-end-port>s+%<nat>s+%<nat-start-port>s+%<nat-end-port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port-reservation') do
            client.delete(url)
        end
    end
end