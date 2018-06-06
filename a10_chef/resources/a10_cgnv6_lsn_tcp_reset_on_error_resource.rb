resource_name :a10_cgnv6_lsn_tcp_reset_on_error

property :a10_name, String, name_property: true
property :outbound, ['disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/tcp/"
    get_url = "/axapi/v3/cgnv6/lsn/tcp/reset-on-error"
    outbound = new_resource.outbound
    uuid = new_resource.uuid

    params = { "reset-on-error": {"outbound": outbound,
        "uuid": uuid,} }

    params[:"reset-on-error"].each do |k, v|
        if not v 
            params[:"reset-on-error"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reset-on-error') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/tcp/reset-on-error"
    outbound = new_resource.outbound
    uuid = new_resource.uuid

    params = { "reset-on-error": {"outbound": outbound,
        "uuid": uuid,} }

    params[:"reset-on-error"].each do |k, v|
        if not v
            params[:"reset-on-error"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reset-on-error"].each do |k, v|
        if v != params[:"reset-on-error"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reset-on-error') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/tcp/reset-on-error"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reset-on-error') do
            client.delete(url)
        end
    end
end