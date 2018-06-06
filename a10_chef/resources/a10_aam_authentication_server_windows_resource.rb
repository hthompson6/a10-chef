resource_name :a10_aam_authentication_server_windows

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String
property :instance_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/server/"
    get_url = "/axapi/v3/aam/authentication/server/windows"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    instance_list = new_resource.instance_list

    params = { "windows": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "instance-list": instance_list,} }

    params[:"windows"].each do |k, v|
        if not v 
            params[:"windows"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating windows') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/windows"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    instance_list = new_resource.instance_list

    params = { "windows": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "instance-list": instance_list,} }

    params[:"windows"].each do |k, v|
        if not v
            params[:"windows"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["windows"].each do |k, v|
        if v != params[:"windows"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating windows') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/server/windows"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting windows') do
            client.delete(url)
        end
    end
end