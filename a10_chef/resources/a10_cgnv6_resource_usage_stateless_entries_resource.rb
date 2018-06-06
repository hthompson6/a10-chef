resource_name :a10_cgnv6_resource_usage_stateless_entries

property :a10_name, String, name_property: true
property :l4_session_count, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/resource-usage/"
    get_url = "/axapi/v3/cgnv6/resource-usage/stateless-entries"
    l4_session_count = new_resource.l4_session_count
    uuid = new_resource.uuid

    params = { "stateless-entries": {"l4-session-count": l4_session_count,
        "uuid": uuid,} }

    params[:"stateless-entries"].each do |k, v|
        if not v 
            params[:"stateless-entries"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating stateless-entries') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/resource-usage/stateless-entries"
    l4_session_count = new_resource.l4_session_count
    uuid = new_resource.uuid

    params = { "stateless-entries": {"l4-session-count": l4_session_count,
        "uuid": uuid,} }

    params[:"stateless-entries"].each do |k, v|
        if not v
            params[:"stateless-entries"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["stateless-entries"].each do |k, v|
        if v != params[:"stateless-entries"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating stateless-entries') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/resource-usage/stateless-entries"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting stateless-entries') do
            client.delete(url)
        end
    end
end