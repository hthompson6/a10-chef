resource_name :a10_interface_lif_ip_rip

property :a10_name, String, name_property: true
property :receive_cfg, Hash
property :uuid, String
property :receive_packet, [true, false]
property :split_horizon_cfg, Hash
property :authentication, Hash
property :send_cfg, Hash
property :send_packet, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/lif/%<ifnum>s/ip/"
    get_url = "/axapi/v3/interface/lif/%<ifnum>s/ip/rip"
    receive_cfg = new_resource.receive_cfg
    uuid = new_resource.uuid
    receive_packet = new_resource.receive_packet
    split_horizon_cfg = new_resource.split_horizon_cfg
    authentication = new_resource.authentication
    send_cfg = new_resource.send_cfg
    send_packet = new_resource.send_packet

    params = { "rip": {"receive-cfg": receive_cfg,
        "uuid": uuid,
        "receive-packet": receive_packet,
        "split-horizon-cfg": split_horizon_cfg,
        "authentication": authentication,
        "send-cfg": send_cfg,
        "send-packet": send_packet,} }

    params[:"rip"].each do |k, v|
        if not v 
            params[:"rip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s/ip/rip"
    receive_cfg = new_resource.receive_cfg
    uuid = new_resource.uuid
    receive_packet = new_resource.receive_packet
    split_horizon_cfg = new_resource.split_horizon_cfg
    authentication = new_resource.authentication
    send_cfg = new_resource.send_cfg
    send_packet = new_resource.send_packet

    params = { "rip": {"receive-cfg": receive_cfg,
        "uuid": uuid,
        "receive-packet": receive_packet,
        "split-horizon-cfg": split_horizon_cfg,
        "authentication": authentication,
        "send-cfg": send_cfg,
        "send-packet": send_packet,} }

    params[:"rip"].each do |k, v|
        if not v
            params[:"rip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rip"].each do |k, v|
        if v != params[:"rip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s/ip/rip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rip') do
            client.delete(url)
        end
    end
end