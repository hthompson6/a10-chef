resource_name :a10_debug_ospf_lsa

property :a10_name, String, name_property: true
property :gererate, [true, false]
property :uuid, String
property :maxage, [true, false]
property :refresh, [true, false]
property :install, [true, false]
property :flooding, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ospf/"
    get_url = "/axapi/v3/debug/ospf/lsa"
    gererate = new_resource.gererate
    uuid = new_resource.uuid
    maxage = new_resource.maxage
    refresh = new_resource.refresh
    install = new_resource.install
    flooding = new_resource.flooding

    params = { "lsa": {"gererate": gererate,
        "uuid": uuid,
        "maxage": maxage,
        "refresh": refresh,
        "install": install,
        "flooding": flooding,} }

    params[:"lsa"].each do |k, v|
        if not v 
            params[:"lsa"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lsa') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/lsa"
    gererate = new_resource.gererate
    uuid = new_resource.uuid
    maxage = new_resource.maxage
    refresh = new_resource.refresh
    install = new_resource.install
    flooding = new_resource.flooding

    params = { "lsa": {"gererate": gererate,
        "uuid": uuid,
        "maxage": maxage,
        "refresh": refresh,
        "install": install,
        "flooding": flooding,} }

    params[:"lsa"].each do |k, v|
        if not v
            params[:"lsa"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lsa"].each do |k, v|
        if v != params[:"lsa"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lsa') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/lsa"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lsa') do
            client.delete(url)
        end
    end
end