resource_name :a10_aam_authentication_relay_form_based_instance

property :a10_name, String, name_property: true
property :uuid, String
property :sampling_enable, Array
property :request_uri_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/form-based/instance/"
    get_url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s"
    uuid = new_resource.uuid
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    request_uri_list = new_resource.request_uri_list

    params = { "instance": {"uuid": uuid,
        "sampling-enable": sampling_enable,
        "name": a10_name,
        "request-uri-list": request_uri_list,} }

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
    url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s"
    uuid = new_resource.uuid
    sampling_enable = new_resource.sampling_enable
    a10_name = new_resource.a10_name
    request_uri_list = new_resource.request_uri_list

    params = { "instance": {"uuid": uuid,
        "sampling-enable": sampling_enable,
        "name": a10_name,
        "request-uri-list": request_uri_list,} }

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
    url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting instance') do
            client.delete(url)
        end
    end
end