resource_name :a10_sys_ut_state_next_state_case

property :a10_name, String, name_property: true
property :action_list, Array
property :repeat, Integer
property :case_number, Integer,required: true
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/"
    get_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s"
    action_list = new_resource.action_list
    repeat = new_resource.repeat
    case_number = new_resource.case_number
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "case": {"action-list": action_list,
        "repeat": repeat,
        "case-number": case_number,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"case"].each do |k, v|
        if not v 
            params[:"case"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating case') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s"
    action_list = new_resource.action_list
    repeat = new_resource.repeat
    case_number = new_resource.case_number
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "case": {"action-list": action_list,
        "repeat": repeat,
        "case-number": case_number,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"case"].each do |k, v|
        if not v
            params[:"case"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["case"].each do |k, v|
        if v != params[:"case"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating case') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting case') do
            client.delete(url)
        end
    end
end