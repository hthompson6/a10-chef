resource_name :a10_visibility_reporting_reporting_db_elastic_search

property :a10_name, String, name_property: true
property :host_ipv6_address, String
property :use_mgmt_port, [true, false]
property :local_host, [true, false]
property :host_name, String
property :host_ipv4_address, String
property :http_port, Integer
property :http_protocol, ['http','https']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/reporting/reporting-db/"
    get_url = "/axapi/v3/visibility/reporting/reporting-db/elastic-search"
    host_ipv6_address = new_resource.host_ipv6_address
    use_mgmt_port = new_resource.use_mgmt_port
    local_host = new_resource.local_host
    host_name = new_resource.host_name
    host_ipv4_address = new_resource.host_ipv4_address
    http_port = new_resource.http_port
    http_protocol = new_resource.http_protocol
    uuid = new_resource.uuid

    params = { "elastic-search": {"host-ipv6-address": host_ipv6_address,
        "use-mgmt-port": use_mgmt_port,
        "local-host": local_host,
        "host-name": host_name,
        "host-ipv4-address": host_ipv4_address,
        "http-port": http_port,
        "http-protocol": http_protocol,
        "uuid": uuid,} }

    params[:"elastic-search"].each do |k, v|
        if not v 
            params[:"elastic-search"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating elastic-search') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting/reporting-db/elastic-search"
    host_ipv6_address = new_resource.host_ipv6_address
    use_mgmt_port = new_resource.use_mgmt_port
    local_host = new_resource.local_host
    host_name = new_resource.host_name
    host_ipv4_address = new_resource.host_ipv4_address
    http_port = new_resource.http_port
    http_protocol = new_resource.http_protocol
    uuid = new_resource.uuid

    params = { "elastic-search": {"host-ipv6-address": host_ipv6_address,
        "use-mgmt-port": use_mgmt_port,
        "local-host": local_host,
        "host-name": host_name,
        "host-ipv4-address": host_ipv4_address,
        "http-port": http_port,
        "http-protocol": http_protocol,
        "uuid": uuid,} }

    params[:"elastic-search"].each do |k, v|
        if not v
            params[:"elastic-search"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["elastic-search"].each do |k, v|
        if v != params[:"elastic-search"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating elastic-search') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting/reporting-db/elastic-search"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting elastic-search') do
            client.delete(url)
        end
    end
end