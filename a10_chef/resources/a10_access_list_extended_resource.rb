resource_name :a10_access_list_extended

property :a10_name, String, name_property: true
property :rules, Array
property :extd, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/access-list/extended/"
    get_url = "/axapi/v3/access-list/extended/%<extd>s"
    rules = new_resource.rules
    extd = new_resource.extd
    uuid = new_resource.uuid

    params = { "extended": {"rules": rules,
        "extd": extd,
        "uuid": uuid,} }

    params[:"extended"].each do |k, v|
        if not v 
            params[:"extended"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating extended') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/access-list/extended/%<extd>s"
    rules = new_resource.rules
    extd = new_resource.extd
    uuid = new_resource.uuid

    params = { "extended": {"rules": rules,
        "extd": extd,
        "uuid": uuid,} }

    params[:"extended"].each do |k, v|
        if not v
            params[:"extended"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["extended"].each do |k, v|
        if v != params[:"extended"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating extended') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/access-list/extended/%<extd>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting extended') do
            client.delete(url)
        end
    end
end