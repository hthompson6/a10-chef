resource_name :a10_overlay_tunnel_vtep_source_ip_address_vni

property :a10_name, String, name_property: true
property :lif, Integer
property :partition, String
property :segment, Integer,required: true
property :gateway, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address/vni/"
    get_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address/vni/%<segment>s"
    lif = new_resource.lif
    partition = new_resource.partition
    segment = new_resource.segment
    gateway = new_resource.gateway
    uuid = new_resource.uuid

    params = { "vni": {"lif": lif,
        "partition": partition,
        "segment": segment,
        "gateway": gateway,
        "uuid": uuid,} }

    params[:"vni"].each do |k, v|
        if not v 
            params[:"vni"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vni') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address/vni/%<segment>s"
    lif = new_resource.lif
    partition = new_resource.partition
    segment = new_resource.segment
    gateway = new_resource.gateway
    uuid = new_resource.uuid

    params = { "vni": {"lif": lif,
        "partition": partition,
        "segment": segment,
        "gateway": gateway,
        "uuid": uuid,} }

    params[:"vni"].each do |k, v|
        if not v
            params[:"vni"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vni"].each do |k, v|
        if v != params[:"vni"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vni') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/source-ip-address/vni/%<segment>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vni') do
            client.delete(url)
        end
    end
end