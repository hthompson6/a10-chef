resource_name :a10_interface_ethernet_nptv6_domain

property :a10_name, String, name_property: true
property :domain_name, String,required: true
property :bind_type, ['inside','outside'],required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/%<ifnum>s/nptv6/domain/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s/nptv6/domain/%<domain-name>s+%<bind-type>s"
    domain_name = new_resource.domain_name
    bind_type = new_resource.bind_type
    uuid = new_resource.uuid

    params = { "domain": {"domain-name": domain_name,
        "bind-type": bind_type,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v 
            params[:"domain"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/nptv6/domain/%<domain-name>s+%<bind-type>s"
    domain_name = new_resource.domain_name
    bind_type = new_resource.bind_type
    uuid = new_resource.uuid

    params = { "domain": {"domain-name": domain_name,
        "bind-type": bind_type,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v
            params[:"domain"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain"].each do |k, v|
        if v != params[:"domain"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/nptv6/domain/%<domain-name>s+%<bind-type>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain') do
            client.delete(url)
        end
    end
end