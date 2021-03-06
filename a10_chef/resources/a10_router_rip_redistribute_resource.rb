resource_name :a10_router_rip_redistribute

property :a10_name, String, name_property: true
property :vip_list, Array
property :redist_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/rip/"
    get_url = "/axapi/v3/router/rip/redistribute"
    vip_list = new_resource.vip_list
    redist_list = new_resource.redist_list
    uuid = new_resource.uuid

    params = { "redistribute": {"vip-list": vip_list,
        "redist-list": redist_list,
        "uuid": uuid,} }

    params[:"redistribute"].each do |k, v|
        if not v 
            params[:"redistribute"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating redistribute') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/rip/redistribute"
    vip_list = new_resource.vip_list
    redist_list = new_resource.redist_list
    uuid = new_resource.uuid

    params = { "redistribute": {"vip-list": vip_list,
        "redist-list": redist_list,
        "uuid": uuid,} }

    params[:"redistribute"].each do |k, v|
        if not v
            params[:"redistribute"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["redistribute"].each do |k, v|
        if v != params[:"redistribute"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating redistribute') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/rip/redistribute"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting redistribute') do
            client.delete(url)
        end
    end
end