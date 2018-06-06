resource_name :a10_key

property :a10_name, String, name_property: true
property :key_chain_flag, [true, false],required: true
property :user_tag, String
property :key_chain_name, String,required: true
property :key_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/key/"
    get_url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s"
    key_chain_flag = new_resource.key_chain_flag
    user_tag = new_resource.user_tag
    key_chain_name = new_resource.key_chain_name
    key_list = new_resource.key_list
    uuid = new_resource.uuid

    params = { "key": {"key-chain-flag": key_chain_flag,
        "user-tag": user_tag,
        "key-chain-name": key_chain_name,
        "key-list": key_list,
        "uuid": uuid,} }

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
    url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s"
    key_chain_flag = new_resource.key_chain_flag
    user_tag = new_resource.user_tag
    key_chain_name = new_resource.key_chain_name
    key_list = new_resource.key_list
    uuid = new_resource.uuid

    params = { "key": {"key-chain-flag": key_chain_flag,
        "user-tag": user_tag,
        "key-chain-name": key_chain_name,
        "key-list": key_list,
        "uuid": uuid,} }

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
    url = "/axapi/v3/key/%<key-chain-flag>s+%<key-chain-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting key') do
            client.delete(url)
        end
    end
end