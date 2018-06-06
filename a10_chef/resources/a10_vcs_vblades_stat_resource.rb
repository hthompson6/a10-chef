resource_name :a10_vcs_vblades_stat

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :vblade_id, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs-vblades/stat/"
    get_url = "/axapi/v3/vcs-vblades/stat/%<vblade-id>s"
    sampling_enable = new_resource.sampling_enable
    vblade_id = new_resource.vblade_id
    uuid = new_resource.uuid

    params = { "stat": {"sampling-enable": sampling_enable,
        "vblade-id": vblade_id,
        "uuid": uuid,} }

    params[:"stat"].each do |k, v|
        if not v 
            params[:"stat"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating stat') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs-vblades/stat/%<vblade-id>s"
    sampling_enable = new_resource.sampling_enable
    vblade_id = new_resource.vblade_id
    uuid = new_resource.uuid

    params = { "stat": {"sampling-enable": sampling_enable,
        "vblade-id": vblade_id,
        "uuid": uuid,} }

    params[:"stat"].each do |k, v|
        if not v
            params[:"stat"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["stat"].each do |k, v|
        if v != params[:"stat"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating stat') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs-vblades/stat/%<vblade-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting stat') do
            client.delete(url)
        end
    end
end