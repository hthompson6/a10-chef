resource_name :a10_license_manager_host

property :a10_name, String, name_property: true
property :host_ipv6, String,required: true
property :host_ipv4, String,required: true
property :port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/license-manager/host/"
    get_url = "/axapi/v3/license-manager/host/%<host-ipv4>s+%<host-ipv6>s"
    host_ipv6 = new_resource.host_ipv6
    host_ipv4 = new_resource.host_ipv4
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "host": {"host-ipv6": host_ipv6,
        "host-ipv4": host_ipv4,
        "port": port,
        "uuid": uuid,} }

    params[:"host"].each do |k, v|
        if not v 
            params[:"host"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating host') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/host/%<host-ipv4>s+%<host-ipv6>s"
    host_ipv6 = new_resource.host_ipv6
    host_ipv4 = new_resource.host_ipv4
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "host": {"host-ipv6": host_ipv6,
        "host-ipv4": host_ipv4,
        "port": port,
        "uuid": uuid,} }

    params[:"host"].each do |k, v|
        if not v
            params[:"host"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["host"].each do |k, v|
        if v != params[:"host"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating host') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/host/%<host-ipv4>s+%<host-ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting host') do
            client.delete(url)
        end
    end
end