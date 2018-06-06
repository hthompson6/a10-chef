resource_name :a10_cgnv6_stateful_firewall_vrid

property :a10_name, String, name_property: true
property :vrid_value, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/stateful-firewall/"
    get_url = "/axapi/v3/cgnv6/stateful-firewall/vrid"
    vrid_value = new_resource.vrid_value
    uuid = new_resource.uuid

    params = { "vrid": {"vrid-value": vrid_value,
        "uuid": uuid,} }

    params[:"vrid"].each do |k, v|
        if not v 
            params[:"vrid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vrid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/vrid"
    vrid_value = new_resource.vrid_value
    uuid = new_resource.uuid

    params = { "vrid": {"vrid-value": vrid_value,
        "uuid": uuid,} }

    params[:"vrid"].each do |k, v|
        if not v
            params[:"vrid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vrid"].each do |k, v|
        if v != params[:"vrid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vrid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/stateful-firewall/vrid"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vrid') do
            client.delete(url)
        end
    end
end