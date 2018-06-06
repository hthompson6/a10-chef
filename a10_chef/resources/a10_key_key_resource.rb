resource_name :a10_key_key

property :a10_name, String, name_property: true
property :key_number, Integer,required: true
property :uuid, String
property :user_tag, String
property :key_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s/key/"
    get_url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s/key/%<key-number>s"
    key_number = new_resource.key_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    key_string = new_resource.key_string

    params = { "key": {"key-number": key_number,
        "uuid": uuid,
        "user-tag": user_tag,
        "key-string": key_string,} }

    params[:"key"].each do |k, v|
        if not v 
            params[:"key"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating key') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s/key/%<key-number>s"
    key_number = new_resource.key_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    key_string = new_resource.key_string

    params = { "key": {"key-number": key_number,
        "uuid": uuid,
        "user-tag": user_tag,
        "key-string": key_string,} }

    params[:"key"].each do |k, v|
        if not v
            params[:"key"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["key"].each do |k, v|
        if v != params[:"key"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating key') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s/key/%<key-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting key') do
            client.delete(url)
        end
    end
end