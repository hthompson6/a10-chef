resource_name :a10_cgnv6_sctp_permit_payload_protocol_protocol_name

property :a10_name, String, name_property: true
property :protocol, ['iua','m2ua','m3ua','sua','m2pa','h.323'],required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-name/"
    get_url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-name/%<protocol>s"
    protocol = new_resource.protocol
    uuid = new_resource.uuid

    params = { "protocol-name": {"protocol": protocol,
        "uuid": uuid,} }

    params[:"protocol-name"].each do |k, v|
        if not v 
            params[:"protocol-name"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating protocol-name') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-name/%<protocol>s"
    protocol = new_resource.protocol
    uuid = new_resource.uuid

    params = { "protocol-name": {"protocol": protocol,
        "uuid": uuid,} }

    params[:"protocol-name"].each do |k, v|
        if not v
            params[:"protocol-name"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["protocol-name"].each do |k, v|
        if v != params[:"protocol-name"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating protocol-name') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-name/%<protocol>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting protocol-name') do
            client.delete(url)
        end
    end
end