resource_name :a10_snmp_server_enable_traps_vcs

property :a10_name, String, name_property: true
property :state_change, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/vcs"
    state_change = new_resource.state_change
    uuid = new_resource.uuid

    params = { "vcs": {"state-change": state_change,
        "uuid": uuid,} }

    params[:"vcs"].each do |k, v|
        if not v 
            params[:"vcs"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vcs') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/vcs"
    state_change = new_resource.state_change
    uuid = new_resource.uuid

    params = { "vcs": {"state-change": state_change,
        "uuid": uuid,} }

    params[:"vcs"].each do |k, v|
        if not v
            params[:"vcs"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vcs"].each do |k, v|
        if v != params[:"vcs"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vcs') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/vcs"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vcs') do
            client.delete(url)
        end
    end
end