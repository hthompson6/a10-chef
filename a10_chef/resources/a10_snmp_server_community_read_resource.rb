resource_name :a10_snmp_server_community_read

property :a10_name, String, name_property: true
property :uuid, String
property :remote, Hash
property :oid_list, Array
property :user_tag, String
property :user, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/community/read/"
    get_url = "/axapi/v3/snmp-server/community/read/%<user>s"
    uuid = new_resource.uuid
    remote = new_resource.remote
    oid_list = new_resource.oid_list
    user_tag = new_resource.user_tag
    user = new_resource.user

    params = { "read": {"uuid": uuid,
        "remote": remote,
        "oid-list": oid_list,
        "user-tag": user_tag,
        "user": user,} }

    params[:"read"].each do |k, v|
        if not v 
            params[:"read"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating read') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/community/read/%<user>s"
    uuid = new_resource.uuid
    remote = new_resource.remote
    oid_list = new_resource.oid_list
    user_tag = new_resource.user_tag
    user = new_resource.user

    params = { "read": {"uuid": uuid,
        "remote": remote,
        "oid-list": oid_list,
        "user-tag": user_tag,
        "user": user,} }

    params[:"read"].each do |k, v|
        if not v
            params[:"read"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["read"].each do |k, v|
        if v != params[:"read"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating read') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/community/read/%<user>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting read') do
            client.delete(url)
        end
    end
end