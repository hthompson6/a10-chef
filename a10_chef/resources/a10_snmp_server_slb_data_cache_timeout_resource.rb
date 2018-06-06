resource_name :a10_snmp_server_slb_data_cache_timeout

property :a10_name, String, name_property: true
property :uuid, String
property :slblimit, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/"
    get_url = "/axapi/v3/snmp-server/slb-data-cache-timeout"
    uuid = new_resource.uuid
    slblimit = new_resource.slblimit

    params = { "slb-data-cache-timeout": {"uuid": uuid,
        "slblimit": slblimit,} }

    params[:"slb-data-cache-timeout"].each do |k, v|
        if not v 
            params[:"slb-data-cache-timeout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating slb-data-cache-timeout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/slb-data-cache-timeout"
    uuid = new_resource.uuid
    slblimit = new_resource.slblimit

    params = { "slb-data-cache-timeout": {"uuid": uuid,
        "slblimit": slblimit,} }

    params[:"slb-data-cache-timeout"].each do |k, v|
        if not v
            params[:"slb-data-cache-timeout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["slb-data-cache-timeout"].each do |k, v|
        if v != params[:"slb-data-cache-timeout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating slb-data-cache-timeout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/slb-data-cache-timeout"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting slb-data-cache-timeout') do
            client.delete(url)
        end
    end
end