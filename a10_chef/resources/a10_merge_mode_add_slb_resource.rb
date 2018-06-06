resource_name :a10_merge_mode_add_slb

property :a10_name, String, name_property: true
property :member, [true, false]
property :virtual_server_port, [true, false]
property :server_port, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/merge-mode-add/"
    get_url = "/axapi/v3/merge-mode-add/slb"
    member = new_resource.member
    virtual_server_port = new_resource.virtual_server_port
    server_port = new_resource.server_port
    uuid = new_resource.uuid

    params = { "slb": {"member": member,
        "virtual-server-port": virtual_server_port,
        "server-port": server_port,
        "uuid": uuid,} }

    params[:"slb"].each do |k, v|
        if not v 
            params[:"slb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating slb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/merge-mode-add/slb"
    member = new_resource.member
    virtual_server_port = new_resource.virtual_server_port
    server_port = new_resource.server_port
    uuid = new_resource.uuid

    params = { "slb": {"member": member,
        "virtual-server-port": virtual_server_port,
        "server-port": server_port,
        "uuid": uuid,} }

    params[:"slb"].each do |k, v|
        if not v
            params[:"slb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["slb"].each do |k, v|
        if v != params[:"slb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating slb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/merge-mode-add/slb"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting slb') do
            client.delete(url)
        end
    end
end