resource_name :a10_cgnv6_template_pcp

property :a10_name, String, name_property: true
property :source_ipv6, String
property :allow_third_party_from_lan, [true, false]
property :map, [true, false]
property :allow_third_party_from_wan, [true, false]
property :maximum, Integer
property :disable_map_filter, [true, false]
property :check_client_nonce, [true, false]
property :minimum, Integer
property :user_tag, String
property :peer, [true, false]
property :announce, [true, false]
property :source_ip, String
property :pcp_server_port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/pcp/"
    get_url = "/axapi/v3/cgnv6/template/pcp/%<name>s"
    source_ipv6 = new_resource.source_ipv6
    allow_third_party_from_lan = new_resource.allow_third_party_from_lan
    a10_name = new_resource.a10_name
    map = new_resource.map
    allow_third_party_from_wan = new_resource.allow_third_party_from_wan
    maximum = new_resource.maximum
    disable_map_filter = new_resource.disable_map_filter
    check_client_nonce = new_resource.check_client_nonce
    minimum = new_resource.minimum
    user_tag = new_resource.user_tag
    peer = new_resource.peer
    announce = new_resource.announce
    source_ip = new_resource.source_ip
    pcp_server_port = new_resource.pcp_server_port
    uuid = new_resource.uuid

    params = { "pcp": {"source-ipv6": source_ipv6,
        "allow-third-party-from-lan": allow_third_party_from_lan,
        "name": a10_name,
        "map": map,
        "allow-third-party-from-wan": allow_third_party_from_wan,
        "maximum": maximum,
        "disable-map-filter": disable_map_filter,
        "check-client-nonce": check_client_nonce,
        "minimum": minimum,
        "user-tag": user_tag,
        "peer": peer,
        "announce": announce,
        "source-ip": source_ip,
        "pcp-server-port": pcp_server_port,
        "uuid": uuid,} }

    params[:"pcp"].each do |k, v|
        if not v 
            params[:"pcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/pcp/%<name>s"
    source_ipv6 = new_resource.source_ipv6
    allow_third_party_from_lan = new_resource.allow_third_party_from_lan
    a10_name = new_resource.a10_name
    map = new_resource.map
    allow_third_party_from_wan = new_resource.allow_third_party_from_wan
    maximum = new_resource.maximum
    disable_map_filter = new_resource.disable_map_filter
    check_client_nonce = new_resource.check_client_nonce
    minimum = new_resource.minimum
    user_tag = new_resource.user_tag
    peer = new_resource.peer
    announce = new_resource.announce
    source_ip = new_resource.source_ip
    pcp_server_port = new_resource.pcp_server_port
    uuid = new_resource.uuid

    params = { "pcp": {"source-ipv6": source_ipv6,
        "allow-third-party-from-lan": allow_third_party_from_lan,
        "name": a10_name,
        "map": map,
        "allow-third-party-from-wan": allow_third_party_from_wan,
        "maximum": maximum,
        "disable-map-filter": disable_map_filter,
        "check-client-nonce": check_client_nonce,
        "minimum": minimum,
        "user-tag": user_tag,
        "peer": peer,
        "announce": announce,
        "source-ip": source_ip,
        "pcp-server-port": pcp_server_port,
        "uuid": uuid,} }

    params[:"pcp"].each do |k, v|
        if not v
            params[:"pcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pcp"].each do |k, v|
        if v != params[:"pcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/pcp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pcp') do
            client.delete(url)
        end
    end
end