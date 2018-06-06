resource_name :a10_aam_authentication_relay_http_basic_instance

property :a10_name, String, name_property: true
property :uuid, String
property :domain_format, ['user-principal-name','down-level-logon-name']
property :domain, String
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/http-basic/instance/"
    get_url = "/axapi/v3/aam/authentication/relay/http-basic/instance/%<name>s"
    uuid = new_resource.uuid
    domain_format = new_resource.domain_format
    domain = new_resource.domain
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name

    params = { "instance": {"uuid": uuid,
        "domain-format": domain_format,
        "domain": domain,
        "sampling-enable": sampling_enable,
        "name": a10_name,} }

    params[:"instance"].each do |k, v|
        if not v 
            params[:"instance"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating instance') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/http-basic/instance/%<name>s"
    uuid = new_resource.uuid
    domain_format = new_resource.domain_format
    domain = new_resource.domain
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name

    params = { "instance": {"uuid": uuid,
        "domain-format": domain_format,
        "domain": domain,
        "sampling-enable": sampling_enable,
        "name": a10_name,} }

    params[:"instance"].each do |k, v|
        if not v
            params[:"instance"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["instance"].each do |k, v|
        if v != params[:"instance"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating instance') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/http-basic/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end