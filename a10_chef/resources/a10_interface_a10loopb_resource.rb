resource_name :a10_interface_a10loopb

property :a10_name, String, name_property: true
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/a10loopb/"
    get_url = "/axapi/v3/interface/a10loopb/%<sampling-enable>s"
    sampling_enable = new_resource.sampling_enable

    params = { "a10loopb": {"sampling-enable": sampling_enable,} }

    params[:"a10loopb"].each do |k, v|
        if not v 
            params[:"a10loopb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating a10loopb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/a10loopb/%<sampling-enable>s"
    sampling_enable = new_resource.sampling_enable

    params = { "a10loopb": {"sampling-enable": sampling_enable,} }

    params[:"a10loopb"].each do |k, v|
        if not v
            params[:"a10loopb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["a10loopb"].each do |k, v|
        if v != params[:"a10loopb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating a10loopb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/a10loopb/%<sampling-enable>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting a10loopb') do
            client.delete(url)
        end
    end
end