resource_name :a10_ntp_trusted_key

property :a10_name, String, name_property: true
property :uuid, String
property :key, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ntp/trusted-key/"
    get_url = "/axapi/v3/ntp/trusted-key/%<key>s"
    uuid = new_resource.uuid
    key = new_resource.key

    params = { "trusted-key": {"uuid": uuid,
        "key": key,} }

    params[:"trusted-key"].each do |k, v|
        if not v 
            params[:"trusted-key"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trusted-key') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/trusted-key/%<key>s"
    uuid = new_resource.uuid
    key = new_resource.key

    params = { "trusted-key": {"uuid": uuid,
        "key": key,} }

    params[:"trusted-key"].each do |k, v|
        if not v
            params[:"trusted-key"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trusted-key"].each do |k, v|
        if v != params[:"trusted-key"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trusted-key') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/trusted-key/%<key>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trusted-key') do
            client.delete(url)
        end
    end
end