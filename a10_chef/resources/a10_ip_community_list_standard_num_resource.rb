resource_name :a10_ip_community_list_standard_num

property :a10_name, String, name_property: true
property :rules_list, Array
property :uuid, String
property :std_list_num, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/community-list/standard-num/"
    get_url = "/axapi/v3/ip/community-list/standard-num/%<std-list-num>s"
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid
    std_list_num = new_resource.std_list_num

    params = { "standard-num": {"rules-list": rules_list,
        "uuid": uuid,
        "std-list-num": std_list_num,} }

    params[:"standard-num"].each do |k, v|
        if not v 
            params[:"standard-num"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating standard-num') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/community-list/standard-num/%<std-list-num>s"
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid
    std_list_num = new_resource.std_list_num

    params = { "standard-num": {"rules-list": rules_list,
        "uuid": uuid,
        "std-list-num": std_list_num,} }

    params[:"standard-num"].each do |k, v|
        if not v
            params[:"standard-num"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["standard-num"].each do |k, v|
        if v != params[:"standard-num"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating standard-num') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/community-list/standard-num/%<std-list-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting standard-num') do
            client.delete(url)
        end
    end
end