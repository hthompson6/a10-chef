resource_name :a10_sys_ut_template

property :a10_name, String, name_property: true
property :udp, Hash
property :ignore_validation, Hash
property :user_tag, String
property :l2, Hash
property :l3, Hash
property :l1, Hash
property :tcp, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s"
    udp = new_resource.udp
    a10_name = new_resource.a10_name
    ignore_validation = new_resource.ignore_validation
    user_tag = new_resource.user_tag
    l2 = new_resource.l2
    l3 = new_resource.l3
    l1 = new_resource.l1
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "template": {"udp": udp,
        "name": a10_name,
        "ignore-validation": ignore_validation,
        "user-tag": user_tag,
        "l2": l2,
        "l3": l3,
        "l1": l1,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s"
    udp = new_resource.udp
    a10_name = new_resource.a10_name
    ignore_validation = new_resource.ignore_validation
    user_tag = new_resource.user_tag
    l2 = new_resource.l2
    l3 = new_resource.l3
    l1 = new_resource.l1
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "template": {"udp": udp,
        "name": a10_name,
        "ignore-validation": ignore_validation,
        "user-tag": user_tag,
        "l2": l2,
        "l3": l3,
        "l1": l1,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end