resource_name :a10_vrrp_a_force_self_standby_persistent

property :a10_name, String, name_property: true
property :vrid, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/force-self-standby-persistent/"
    get_url = "/axapi/v3/vrrp-a/force-self-standby-persistent/%<vrid>s"
    vrid = new_resource.vrid
    uuid = new_resource.uuid

    params = { "force-self-standby-persistent": {"vrid": vrid,
        "uuid": uuid,} }

    params[:"force-self-standby-persistent"].each do |k, v|
        if not v 
            params[:"force-self-standby-persistent"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating force-self-standby-persistent') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/force-self-standby-persistent/%<vrid>s"
    vrid = new_resource.vrid
    uuid = new_resource.uuid

    params = { "force-self-standby-persistent": {"vrid": vrid,
        "uuid": uuid,} }

    params[:"force-self-standby-persistent"].each do |k, v|
        if not v
            params[:"force-self-standby-persistent"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["force-self-standby-persistent"].each do |k, v|
        if v != params[:"force-self-standby-persistent"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating force-self-standby-persistent') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/force-self-standby-persistent/%<vrid>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting force-self-standby-persistent') do
            client.delete(url)
        end
    end
end