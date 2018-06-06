resource_name :a10_cgnv6_sctp_permit_payload_protocol_protocol_id

property :a10_name, String, name_property: true
property :id, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-id/"
    get_url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-id/%<id>s"
    id = new_resource.id
    uuid = new_resource.uuid

    params = { "protocol-id": {"id": id,
        "uuid": uuid,} }

    params[:"protocol-id"].each do |k, v|
        if not v 
            params[:"protocol-id"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating protocol-id') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-id/%<id>s"
    id = new_resource.id
    uuid = new_resource.uuid

    params = { "protocol-id": {"id": id,
        "uuid": uuid,} }

    params[:"protocol-id"].each do |k, v|
        if not v
            params[:"protocol-id"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["protocol-id"].each do |k, v|
        if v != params[:"protocol-id"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating protocol-id') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/sctp/permit-payload-protocol/protocol-id/%<id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting protocol-id') do
            client.delete(url)
        end
    end
end