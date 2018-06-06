resource_name :a10_netflow_monitor_sample_ethernet

property :a10_name, String, name_property: true
property :ifindex, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/%<name>s/sample/ethernet/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s/sample/ethernet/%<ifindex>s"
    ifindex = new_resource.ifindex
    uuid = new_resource.uuid

    params = { "ethernet": {"ifindex": ifindex,
        "uuid": uuid,} }

    params[:"ethernet"].each do |k, v|
        if not v 
            params[:"ethernet"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ethernet') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/sample/ethernet/%<ifindex>s"
    ifindex = new_resource.ifindex
    uuid = new_resource.uuid

    params = { "ethernet": {"ifindex": ifindex,
        "uuid": uuid,} }

    params[:"ethernet"].each do |k, v|
        if not v
            params[:"ethernet"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ethernet"].each do |k, v|
        if v != params[:"ethernet"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ethernet') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/sample/ethernet/%<ifindex>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ethernet') do
            client.delete(url)
        end
    end
end