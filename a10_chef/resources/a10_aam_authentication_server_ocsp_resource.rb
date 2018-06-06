resource_name :a10_aam_authentication_server_ocsp

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String
property :instance_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/"
    get_url = "/axapi/v3/aam/authentication/server/ocsp"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    instance_list = new_resource.instance_list

    params = { "ocsp": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "instance-list": instance_list,} }

    params[:"ocsp"].each do |k, v|
        if not v 
            params[:"ocsp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ocsp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/ocsp"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    instance_list = new_resource.instance_list

    params = { "ocsp": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "instance-list": instance_list,} }

    params[:"ocsp"].each do |k, v|
        if not v
            params[:"ocsp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ocsp"].each do |k, v|
        if v != params[:"ocsp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ocsp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/ocsp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ocsp') do
            client.delete(url)
        end
    end
end