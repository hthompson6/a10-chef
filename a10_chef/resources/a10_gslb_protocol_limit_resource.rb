resource_name :a10_gslb_protocol_limit

property :a10_name, String, name_property: true
property :ardt_response, Integer
property :uuid, String
property :conn_response, Integer
property :ardt_session, Integer
property :ardt_query, Integer
property :message, Integer
property :response, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/protocol/"
    get_url = "/axapi/v3/gslb/protocol/limit"
    ardt_response = new_resource.ardt_response
    uuid = new_resource.uuid
    conn_response = new_resource.conn_response
    ardt_session = new_resource.ardt_session
    ardt_query = new_resource.ardt_query
    message = new_resource.message
    response = new_resource.response

    params = { "limit": {"ardt-response": ardt_response,
        "uuid": uuid,
        "conn-response": conn_response,
        "ardt-session": ardt_session,
        "ardt-query": ardt_query,
        "message": message,
        "response": response,} }

    params[:"limit"].each do |k, v|
        if not v 
            params[:"limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/protocol/limit"
    ardt_response = new_resource.ardt_response
    uuid = new_resource.uuid
    conn_response = new_resource.conn_response
    ardt_session = new_resource.ardt_session
    ardt_query = new_resource.ardt_query
    message = new_resource.message
    response = new_resource.response

    params = { "limit": {"ardt-response": ardt_response,
        "uuid": uuid,
        "conn-response": conn_response,
        "ardt-session": ardt_session,
        "ardt-query": ardt_query,
        "message": message,
        "response": response,} }

    params[:"limit"].each do |k, v|
        if not v
            params[:"limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["limit"].each do |k, v|
        if v != params[:"limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/protocol/limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting limit') do
            client.delete(url)
        end
    end
end