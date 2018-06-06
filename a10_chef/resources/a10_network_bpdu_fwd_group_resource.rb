resource_name :a10_network_bpdu_fwd_group

property :a10_name, String, name_property: true
property :bpdu_fwd_group_number, Integer,required: true
property :uuid, String
property :user_tag, String
property :ethernet_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/bpdu-fwd-group/"
    get_url = "/axapi/v3/network/bpdu-fwd-group/%<bpdu-fwd-group-number>s"
    bpdu_fwd_group_number = new_resource.bpdu_fwd_group_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ethernet_list = new_resource.ethernet_list

    params = { "bpdu-fwd-group": {"bpdu-fwd-group-number": bpdu_fwd_group_number,
        "uuid": uuid,
        "user-tag": user_tag,
        "ethernet-list": ethernet_list,} }

    params[:"bpdu-fwd-group"].each do |k, v|
        if not v 
            params[:"bpdu-fwd-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bpdu-fwd-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/bpdu-fwd-group/%<bpdu-fwd-group-number>s"
    bpdu_fwd_group_number = new_resource.bpdu_fwd_group_number
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ethernet_list = new_resource.ethernet_list

    params = { "bpdu-fwd-group": {"bpdu-fwd-group-number": bpdu_fwd_group_number,
        "uuid": uuid,
        "user-tag": user_tag,
        "ethernet-list": ethernet_list,} }

    params[:"bpdu-fwd-group"].each do |k, v|
        if not v
            params[:"bpdu-fwd-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bpdu-fwd-group"].each do |k, v|
        if v != params[:"bpdu-fwd-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bpdu-fwd-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/bpdu-fwd-group/%<bpdu-fwd-group-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bpdu-fwd-group') do
            client.delete(url)
        end
    end
end