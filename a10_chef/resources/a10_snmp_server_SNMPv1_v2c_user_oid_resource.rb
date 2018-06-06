resource_name :a10_snmp_server_SNMPv1_v2c_user_oid

property :a10_name, String, name_property: true
property :remote, Hash
property :oid_val, String,required: true
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s/oid/"
    get_url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s/oid/%<oid-val>s"
    remote = new_resource.remote
    oid_val = new_resource.oid_val
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "oid": {"remote": remote,
        "oid-val": oid_val,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"oid"].each do |k, v|
        if not v 
            params[:"oid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating oid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s/oid/%<oid-val>s"
    remote = new_resource.remote
    oid_val = new_resource.oid_val
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "oid": {"remote": remote,
        "oid-val": oid_val,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"oid"].each do |k, v|
        if not v
            params[:"oid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["oid"].each do |k, v|
        if v != params[:"oid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating oid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/SNMPv1-v2c/user/%<user>s/oid/%<oid-val>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting oid') do
            client.delete(url)
        end
    end
end