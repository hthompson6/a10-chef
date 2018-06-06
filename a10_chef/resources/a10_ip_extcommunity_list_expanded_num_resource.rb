resource_name :a10_ip_extcommunity_list_expanded_num

property :a10_name, String, name_property: true
property :ext_list_num, Integer,required: true
property :rules_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/extcommunity-list/expanded-num/"
    get_url = "/axapi/v3/ip/extcommunity-list/expanded-num/%<ext-list-num>s"
    ext_list_num = new_resource.ext_list_num
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid

    params = { "expanded-num": {"ext-list-num": ext_list_num,
        "rules-list": rules_list,
        "uuid": uuid,} }

    params[:"expanded-num"].each do |k, v|
        if not v 
            params[:"expanded-num"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating expanded-num') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/extcommunity-list/expanded-num/%<ext-list-num>s"
    ext_list_num = new_resource.ext_list_num
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid

    params = { "expanded-num": {"ext-list-num": ext_list_num,
        "rules-list": rules_list,
        "uuid": uuid,} }

    params[:"expanded-num"].each do |k, v|
        if not v
            params[:"expanded-num"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["expanded-num"].each do |k, v|
        if v != params[:"expanded-num"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating expanded-num') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/extcommunity-list/expanded-num/%<ext-list-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting expanded-num') do
            client.delete(url)
        end
    end
end