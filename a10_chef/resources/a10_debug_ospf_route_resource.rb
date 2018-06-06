resource_name :a10_debug_ospf_route

property :a10_name, String, name_property: true
property :ia, [true, false]
property :ase, [true, false]
property :install, [true, false]
property :spf, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ospf/"
    get_url = "/axapi/v3/debug/ospf/route"
    ia = new_resource.ia
    ase = new_resource.ase
    install = new_resource.install
    spf = new_resource.spf
    uuid = new_resource.uuid

    params = { "route": {"ia": ia,
        "ase": ase,
        "install": install,
        "spf": spf,
        "uuid": uuid,} }

    params[:"route"].each do |k, v|
        if not v 
            params[:"route"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating route') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/route"
    ia = new_resource.ia
    ase = new_resource.ase
    install = new_resource.install
    spf = new_resource.spf
    uuid = new_resource.uuid

    params = { "route": {"ia": ia,
        "ase": ase,
        "install": install,
        "spf": spf,
        "uuid": uuid,} }

    params[:"route"].each do |k, v|
        if not v
            params[:"route"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["route"].each do |k, v|
        if v != params[:"route"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating route') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/route"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting route') do
            client.delete(url)
        end
    end
end