resource_name :a10_sys_ut_event_action_l1

property :a10_name, String, name_property: true
property :eth_list, Array
property :uuid, String
property :auto, [true, false]
property :value, Integer
property :length, [true, false]
property :trunk_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l1"
    eth_list = new_resource.eth_list
    uuid = new_resource.uuid
    auto = new_resource.auto
    value = new_resource.value
    length = new_resource.length
    trunk_list = new_resource.trunk_list

    params = { "l1": {"eth-list": eth_list,
        "uuid": uuid,
        "auto": auto,
        "value": value,
        "length": length,
        "trunk_list": trunk_list,} }

    params[:"l1"].each do |k, v|
        if not v 
            params[:"l1"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l1') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l1"
    eth_list = new_resource.eth_list
    uuid = new_resource.uuid
    auto = new_resource.auto
    value = new_resource.value
    length = new_resource.length
    trunk_list = new_resource.trunk_list

    params = { "l1": {"eth-list": eth_list,
        "uuid": uuid,
        "auto": auto,
        "value": value,
        "length": length,
        "trunk_list": trunk_list,} }

    params[:"l1"].each do |k, v|
        if not v
            params[:"l1"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l1"].each do |k, v|
        if v != params[:"l1"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l1') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l1"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l1') do
            client.delete(url)
        end
    end
end