resource_name :a10_snmp_server_view

property :a10_name, String, name_property: true
property :ntype, ['included','excluded']
property :oid, String,required: true
property :mask, String
property :uuid, String
property :viewname, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/view/"
    get_url = "/axapi/v3/snmp-server/view/%<viewname>s+%<oid>s"
    ntype = new_resource.ntype
    oid = new_resource.oid
    mask = new_resource.mask
    uuid = new_resource.uuid
    viewname = new_resource.viewname

    params = { "view": {"type": ntype,
        "oid": oid,
        "mask": mask,
        "uuid": uuid,
        "viewname": viewname,} }

    params[:"view"].each do |k, v|
        if not v 
            params[:"view"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating view') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/view/%<viewname>s+%<oid>s"
    ntype = new_resource.ntype
    oid = new_resource.oid
    mask = new_resource.mask
    uuid = new_resource.uuid
    viewname = new_resource.viewname

    params = { "view": {"type": ntype,
        "oid": oid,
        "mask": mask,
        "uuid": uuid,
        "viewname": viewname,} }

    params[:"view"].each do |k, v|
        if not v
            params[:"view"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["view"].each do |k, v|
        if v != params[:"view"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating view') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/view/%<viewname>s+%<oid>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting view') do
            client.delete(url)
        end
    end
end