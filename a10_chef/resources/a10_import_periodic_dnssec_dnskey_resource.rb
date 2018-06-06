resource_name :a10_import_periodic_dnssec_dnskey

property :a10_name, String, name_property: true
property :dnssec_dnskey, String,required: true
property :use_mgmt_port, [true, false]
property :uuid, String
property :remote_file, String
property :period, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/dnssec-dnskey/"
    get_url = "/axapi/v3/import-periodic/dnssec-dnskey/%<dnssec-dnskey>s"
    dnssec_dnskey = new_resource.dnssec_dnskey
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "dnssec-dnskey": {"dnssec-dnskey": dnssec_dnskey,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

    params[:"dnssec-dnskey"].each do |k, v|
        if not v 
            params[:"dnssec-dnskey"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dnssec-dnskey') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/dnssec-dnskey/%<dnssec-dnskey>s"
    dnssec_dnskey = new_resource.dnssec_dnskey
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "dnssec-dnskey": {"dnssec-dnskey": dnssec_dnskey,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

    params[:"dnssec-dnskey"].each do |k, v|
        if not v
            params[:"dnssec-dnskey"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dnssec-dnskey"].each do |k, v|
        if v != params[:"dnssec-dnskey"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dnssec-dnskey') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import-periodic/dnssec-dnskey/%<dnssec-dnskey>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dnssec-dnskey') do
            client.delete(url)
        end
    end
end