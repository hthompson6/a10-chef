resource_name :a10_snmp_server_group

property :a10_name, String, name_property: true
property :read, String
property :groupname, String,required: true
property :v3, ['auth','noauth','priv']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/group/"
    get_url = "/axapi/v3/snmp-server/group/%<groupname>s"
    read = new_resource.read
    groupname = new_resource.groupname
    v3 = new_resource.v3
    uuid = new_resource.uuid

    params = { "group": {"read": read,
        "groupname": groupname,
        "v3": v3,
        "uuid": uuid,} }

    params[:"group"].each do |k, v|
        if not v 
            params[:"group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/group/%<groupname>s"
    read = new_resource.read
    groupname = new_resource.groupname
    v3 = new_resource.v3
    uuid = new_resource.uuid

    params = { "group": {"read": read,
        "groupname": groupname,
        "v3": v3,
        "uuid": uuid,} }

    params[:"group"].each do |k, v|
        if not v
            params[:"group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["group"].each do |k, v|
        if v != params[:"group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/group/%<groupname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting group') do
            client.delete(url)
        end
    end
end