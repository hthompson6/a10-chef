resource_name :a10_slb_template_dblb

property :a10_name, String, name_property: true
property :server_version, ['MSSQL2008','MSSQL2012','MySQL']
property :class_list, String
property :user_tag, String
property :calc_sha1, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/dblb/"
    get_url = "/axapi/v3/slb/template/dblb/%<name>s"
    server_version = new_resource.server_version
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    user_tag = new_resource.user_tag
    calc_sha1 = new_resource.calc_sha1
    uuid = new_resource.uuid

    params = { "dblb": {"server-version": server_version,
        "name": a10_name,
        "class-list": class_list,
        "user-tag": user_tag,
        "calc-sha1": calc_sha1,
        "uuid": uuid,} }

    params[:"dblb"].each do |k, v|
        if not v 
            params[:"dblb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dblb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dblb/%<name>s"
    server_version = new_resource.server_version
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    user_tag = new_resource.user_tag
    calc_sha1 = new_resource.calc_sha1
    uuid = new_resource.uuid

    params = { "dblb": {"server-version": server_version,
        "name": a10_name,
        "class-list": class_list,
        "user-tag": user_tag,
        "calc-sha1": calc_sha1,
        "uuid": uuid,} }

    params[:"dblb"].each do |k, v|
        if not v
            params[:"dblb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dblb"].each do |k, v|
        if v != params[:"dblb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dblb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dblb/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dblb') do
            client.delete(url)
        end
    end
end