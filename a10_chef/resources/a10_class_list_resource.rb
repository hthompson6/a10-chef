resource_name :a10_class_list

property :a10_name, String, name_property: true
property :dns, Array
property :ipv4_list, Array
property :uuid, String
property :user_tag, String
property :ac_list, Array
property :str_list, Array
property :file, [true, false]
property :ntype, ['ac','dns','ipv4','ipv6','string','string-case-insensitive']
property :ipv6_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/class-list/"
    get_url = "/axapi/v3/class-list/%<name>s"
    dns = new_resource.dns
    a10_name = new_resource.a10_name
    ipv4_list = new_resource.ipv4_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ac_list = new_resource.ac_list
    str_list = new_resource.str_list
    file = new_resource.file
    ntype = new_resource.ntype
    ipv6_list = new_resource.ipv6_list

    params = { "class-list": {"dns": dns,
        "name": a10_name,
        "ipv4-list": ipv4_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "ac-list": ac_list,
        "str-list": str_list,
        "file": file,
        "type": ntype,
        "ipv6-list": ipv6_list,} }

    params[:"class-list"].each do |k, v|
        if not v 
            params[:"class-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating class-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/class-list/%<name>s"
    dns = new_resource.dns
    a10_name = new_resource.a10_name
    ipv4_list = new_resource.ipv4_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    ac_list = new_resource.ac_list
    str_list = new_resource.str_list
    file = new_resource.file
    ntype = new_resource.ntype
    ipv6_list = new_resource.ipv6_list

    params = { "class-list": {"dns": dns,
        "name": a10_name,
        "ipv4-list": ipv4_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "ac-list": ac_list,
        "str-list": str_list,
        "file": file,
        "type": ntype,
        "ipv6-list": ipv6_list,} }

    params[:"class-list"].each do |k, v|
        if not v
            params[:"class-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["class-list"].each do |k, v|
        if v != params[:"class-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating class-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/class-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list') do
            client.delete(url)
        end
    end
end