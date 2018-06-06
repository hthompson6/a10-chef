resource_name :a10_cgnv6_lsn_endpoint_independent_filtering_tcp

property :a10_name, String, name_property: true
property :port_list, Array
property :uuid, String
property :session_limit, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/endpoint-independent-filtering/"
    get_url = "/axapi/v3/cgnv6/lsn/endpoint-independent-filtering/tcp"
    port_list = new_resource.port_list
    uuid = new_resource.uuid
    session_limit = new_resource.session_limit

    params = { "tcp": {"port-list": port_list,
        "uuid": uuid,
        "session-limit": session_limit,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/endpoint-independent-filtering/tcp"
    port_list = new_resource.port_list
    uuid = new_resource.uuid
    session_limit = new_resource.session_limit

    params = { "tcp": {"port-list": port_list,
        "uuid": uuid,
        "session-limit": session_limit,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/endpoint-independent-filtering/tcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end