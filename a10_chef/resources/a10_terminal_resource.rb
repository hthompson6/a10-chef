resource_name :a10_terminal

property :a10_name, String, name_property: true
property :uuid, String
property :gslb_cfg, Hash
property :history_cfg, Hash
property :idle_timeout, Integer
property :prompt_cfg, Hash
property :width, Integer
property :length, Integer
property :editing, [true, false]
property :auto_size, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/terminal"
    uuid = new_resource.uuid
    gslb_cfg = new_resource.gslb_cfg
    history_cfg = new_resource.history_cfg
    idle_timeout = new_resource.idle_timeout
    prompt_cfg = new_resource.prompt_cfg
    width = new_resource.width
    length = new_resource.length
    editing = new_resource.editing
    auto_size = new_resource.auto_size

    params = { "terminal": {"uuid": uuid,
        "gslb-cfg": gslb_cfg,
        "history-cfg": history_cfg,
        "idle-timeout": idle_timeout,
        "prompt-cfg": prompt_cfg,
        "width": width,
        "length": length,
        "editing": editing,
        "auto-size": auto_size,} }

    params[:"terminal"].each do |k, v|
        if not v 
            params[:"terminal"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating terminal') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/terminal"
    uuid = new_resource.uuid
    gslb_cfg = new_resource.gslb_cfg
    history_cfg = new_resource.history_cfg
    idle_timeout = new_resource.idle_timeout
    prompt_cfg = new_resource.prompt_cfg
    width = new_resource.width
    length = new_resource.length
    editing = new_resource.editing
    auto_size = new_resource.auto_size

    params = { "terminal": {"uuid": uuid,
        "gslb-cfg": gslb_cfg,
        "history-cfg": history_cfg,
        "idle-timeout": idle_timeout,
        "prompt-cfg": prompt_cfg,
        "width": width,
        "length": length,
        "editing": editing,
        "auto-size": auto_size,} }

    params[:"terminal"].each do |k, v|
        if not v
            params[:"terminal"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["terminal"].each do |k, v|
        if v != params[:"terminal"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating terminal') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/terminal"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting terminal') do
            client.delete(url)
        end
    end
end