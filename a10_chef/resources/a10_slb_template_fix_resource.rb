resource_name :a10_slb_template_fix

property :a10_name, String, name_property: true
property :logging, ['init','term','both']
property :tag_switching, Array
property :user_tag, String
property :insert_client_ip, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/fix/"
    get_url = "/axapi/v3/slb/template/fix/%<name>s"
    logging = new_resource.logging
    a10_name = new_resource.a10_name
    tag_switching = new_resource.tag_switching
    user_tag = new_resource.user_tag
    insert_client_ip = new_resource.insert_client_ip
    uuid = new_resource.uuid

    params = { "fix": {"logging": logging,
        "name": a10_name,
        "tag-switching": tag_switching,
        "user-tag": user_tag,
        "insert-client-ip": insert_client_ip,
        "uuid": uuid,} }

    params[:"fix"].each do |k, v|
        if not v 
            params[:"fix"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating fix') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/fix/%<name>s"
    logging = new_resource.logging
    a10_name = new_resource.a10_name
    tag_switching = new_resource.tag_switching
    user_tag = new_resource.user_tag
    insert_client_ip = new_resource.insert_client_ip
    uuid = new_resource.uuid

    params = { "fix": {"logging": logging,
        "name": a10_name,
        "tag-switching": tag_switching,
        "user-tag": user_tag,
        "insert-client-ip": insert_client_ip,
        "uuid": uuid,} }

    params[:"fix"].each do |k, v|
        if not v
            params[:"fix"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["fix"].each do |k, v|
        if v != params[:"fix"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating fix') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/fix/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting fix') do
            client.delete(url)
        end
    end
end