resource_name :a10_slb_ssl_expire_check_exception

property :a10_name, String, name_property: true
property :a10_action, ['add','delete','clean']
property :certificate_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/ssl-expire-check/"
    get_url = "/axapi/v3/slb/ssl-expire-check/exception"
    a10_name = new_resource.a10_name
    certificate_name = new_resource.certificate_name

    params = { "exception": {"action": a10_action,
        "certificate-name": certificate_name,} }

    params[:"exception"].each do |k, v|
        if not v 
            params[:"exception"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating exception') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/ssl-expire-check/exception"
    a10_name = new_resource.a10_name
    certificate_name = new_resource.certificate_name

    params = { "exception": {"action": a10_action,
        "certificate-name": certificate_name,} }

    params[:"exception"].each do |k, v|
        if not v
            params[:"exception"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["exception"].each do |k, v|
        if v != params[:"exception"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating exception') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/ssl-expire-check/exception"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting exception') do
            client.delete(url)
        end
    end
end