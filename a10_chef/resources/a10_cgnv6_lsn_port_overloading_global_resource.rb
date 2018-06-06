resource_name :a10_cgnv6_lsn_port_overloading_global

property :a10_name, String, name_property: true
property :unique, ['destination-address','destination-address-and-port']
property :allow_different_user, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/port-overloading/"
    get_url = "/axapi/v3/cgnv6/lsn/port-overloading/global"
    unique = new_resource.unique
    allow_different_user = new_resource.allow_different_user
    uuid = new_resource.uuid

    params = { "global": {"unique": unique,
        "allow-different-user": allow_different_user,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/port-overloading/global"
    unique = new_resource.unique
    allow_different_user = new_resource.allow_different_user
    uuid = new_resource.uuid

    params = { "global": {"unique": unique,
        "allow-different-user": allow_different_user,
        "uuid": uuid,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/port-overloading/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end