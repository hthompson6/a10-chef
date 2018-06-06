resource_name :a10_cgnv6_lsn_port_reservation

property :a10_name, String, name_property: true
property :inside_port_start, Integer,required: true
property :uuid, String
property :nat_port_start, Integer,required: true
property :inside_port_end, Integer,required: true
property :inside, String,required: true
property :nat, String,required: true
property :nat_port_end, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/port-reservation/"
    get_url = "/axapi/v3/cgnv6/lsn/port-reservation/%<inside>s+%<inside-port-start>s+%<inside-port-end>s+%<nat>s+%<nat-port-start>s+%<nat-port-end>s"
    inside_port_start = new_resource.inside_port_start
    uuid = new_resource.uuid
    nat_port_start = new_resource.nat_port_start
    inside_port_end = new_resource.inside_port_end
    inside = new_resource.inside
    nat = new_resource.nat
    nat_port_end = new_resource.nat_port_end

    params = { "port-reservation": {"inside-port-start": inside_port_start,
        "uuid": uuid,
        "nat-port-start": nat_port_start,
        "inside-port-end": inside_port_end,
        "inside": inside,
        "nat": nat,
        "nat-port-end": nat_port_end,} }

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
    url = "/axapi/v3/cgnv6/lsn/port-reservation/%<inside>s+%<inside-port-start>s+%<inside-port-end>s+%<nat>s+%<nat-port-start>s+%<nat-port-end>s"
    inside_port_start = new_resource.inside_port_start
    uuid = new_resource.uuid
    nat_port_start = new_resource.nat_port_start
    inside_port_end = new_resource.inside_port_end
    inside = new_resource.inside
    nat = new_resource.nat
    nat_port_end = new_resource.nat_port_end

    params = { "port-reservation": {"inside-port-start": inside_port_start,
        "uuid": uuid,
        "nat-port-start": nat_port_start,
        "inside-port-end": inside_port_end,
        "inside": inside,
        "nat": nat,
        "nat-port-end": nat_port_end,} }

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
    url = "/axapi/v3/cgnv6/lsn/port-reservation/%<inside>s+%<inside-port-start>s+%<inside-port-end>s+%<nat>s+%<nat-port-start>s+%<nat-port-end>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port-reservation') do
            client.delete(url)
        end
    end
end