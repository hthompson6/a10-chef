resource_name :a10_session_filter

property :a10_name, String, name_property: true
property :filter_cfg, Hash
property :set, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/session-filter/"
    get_url = "/axapi/v3/session-filter/%<name>s"
    filter_cfg = new_resource.filter_cfg
    set = new_resource.set
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "session-filter": {"filter-cfg": filter_cfg,
        "set": set,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"session-filter"].each do |k, v|
        if not v 
            params[:"session-filter"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating session-filter') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/session-filter/%<name>s"
    filter_cfg = new_resource.filter_cfg
    set = new_resource.set
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "session-filter": {"filter-cfg": filter_cfg,
        "set": set,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"session-filter"].each do |k, v|
        if not v
            params[:"session-filter"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["session-filter"].each do |k, v|
        if v != params[:"session-filter"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating session-filter') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/session-filter/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting session-filter') do
            client.delete(url)
        end
    end
end