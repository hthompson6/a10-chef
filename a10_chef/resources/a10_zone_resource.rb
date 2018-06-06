resource_name :a10_zone

property :a10_name, String, name_property: true
property :vlan, Hash
property :user_tag, String
property :interface, Hash
property :local_zone_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/zone/"
    get_url = "/axapi/v3/zone/%<name>s"
    a10_name = new_resource.a10_name
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    interface = new_resource.interface
    local_zone_cfg = new_resource.local_zone_cfg
    uuid = new_resource.uuid

    params = { "zone": {"name": a10_name,
        "vlan": vlan,
        "user-tag": user_tag,
        "interface": interface,
        "local-zone-cfg": local_zone_cfg,
        "uuid": uuid,} }

    params[:"zone"].each do |k, v|
        if not v 
            params[:"zone"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating zone') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s"
    a10_name = new_resource.a10_name
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    interface = new_resource.interface
    local_zone_cfg = new_resource.local_zone_cfg
    uuid = new_resource.uuid

    params = { "zone": {"name": a10_name,
        "vlan": vlan,
        "user-tag": user_tag,
        "interface": interface,
        "local-zone-cfg": local_zone_cfg,
        "uuid": uuid,} }

    params[:"zone"].each do |k, v|
        if not v
            params[:"zone"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["zone"].each do |k, v|
        if v != params[:"zone"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating zone') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/zone/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting zone') do
            client.delete(url)
        end
    end
end