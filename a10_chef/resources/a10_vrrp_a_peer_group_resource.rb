resource_name :a10_vrrp_a_peer_group

property :a10_name, String, name_property: true
property :peer, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/"
    get_url = "/axapi/v3/vrrp-a/peer-group"
    peer = new_resource.peer
    uuid = new_resource.uuid

    params = { "peer-group": {"peer": peer,
        "uuid": uuid,} }

    params[:"peer-group"].each do |k, v|
        if not v 
            params[:"peer-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating peer-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/peer-group"
    peer = new_resource.peer
    uuid = new_resource.uuid

    params = { "peer-group": {"peer": peer,
        "uuid": uuid,} }

    params[:"peer-group"].each do |k, v|
        if not v
            params[:"peer-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["peer-group"].each do |k, v|
        if v != params[:"peer-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating peer-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/peer-group"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting peer-group') do
            client.delete(url)
        end
    end
end