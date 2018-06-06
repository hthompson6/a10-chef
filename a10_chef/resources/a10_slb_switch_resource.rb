resource_name :a10_slb_switch

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/switch"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "switch": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"switch"].each do |k, v|
        if not v 
            params[:"switch"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating switch') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/switch"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "switch": {"sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"switch"].each do |k, v|
        if not v
            params[:"switch"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["switch"].each do |k, v|
        if v != params[:"switch"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating switch') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/switch"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting switch') do
            client.delete(url)
        end
    end
end