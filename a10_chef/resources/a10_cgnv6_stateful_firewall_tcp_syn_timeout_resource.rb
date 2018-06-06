resource_name :a10_cgnv6_stateful_firewall_tcp_syn_timeout

property :a10_name, String, name_property: true
property :syn_timeout_val, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/stateful-firewall/tcp/"
    get_url = "/axapi/v3/cgnv6/stateful-firewall/tcp/syn-timeout"
    syn_timeout_val = new_resource.syn_timeout_val
    uuid = new_resource.uuid

    params = { "syn-timeout": {"syn-timeout-val": syn_timeout_val,
        "uuid": uuid,} }

    params[:"syn-timeout"].each do |k, v|
        if not v 
            params[:"syn-timeout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating syn-timeout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/tcp/syn-timeout"
    syn_timeout_val = new_resource.syn_timeout_val
    uuid = new_resource.uuid

    params = { "syn-timeout": {"syn-timeout-val": syn_timeout_val,
        "uuid": uuid,} }

    params[:"syn-timeout"].each do |k, v|
        if not v
            params[:"syn-timeout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["syn-timeout"].each do |k, v|
        if v != params[:"syn-timeout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating syn-timeout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/tcp/syn-timeout"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting syn-timeout') do
            client.delete(url)
        end
    end
end