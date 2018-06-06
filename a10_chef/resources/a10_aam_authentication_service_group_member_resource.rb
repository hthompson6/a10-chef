resource_name :a10_aam_authentication_service_group_member

property :a10_name, String, name_property: true
property :member_priority, Integer
property :uuid, String
property :user_tag, String
property :sampling_enable, Array
property :member_state, ['enable','disable']
property :port, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/service-group/%<name>s/member/"
    get_url = "/axapi/v3/aam/authentication/service-group/%<name>s/member/%<name>s+%<port>s"
    member_priority = new_resource.member_priority
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    member_state = new_resource.member_state
    port = new_resource.port
    a10_name = new_resource.a10_name

    params = { "member": {"member-priority": member_priority,
        "uuid": uuid,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "member-state": member_state,
        "port": port,
        "name": a10_name,} }

    params[:"member"].each do |k, v|
        if not v 
            params[:"member"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating member') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/service-group/%<name>s/member/%<name>s+%<port>s"
    member_priority = new_resource.member_priority
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    member_state = new_resource.member_state
    port = new_resource.port
    a10_name = new_resource.a10_name

    params = { "member": {"member-priority": member_priority,
        "uuid": uuid,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "member-state": member_state,
        "port": port,
        "name": a10_name,} }

    params[:"member"].each do |k, v|
        if not v
            params[:"member"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["member"].each do |k, v|
        if v != params[:"member"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating member') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/service-group/%<name>s/member/%<name>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting member') do
            client.delete(url)
        end
    end
end