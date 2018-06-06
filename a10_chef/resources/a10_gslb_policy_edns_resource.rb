resource_name :a10_gslb_policy_edns

property :a10_name, String, name_property: true
property :uuid, String
property :client_subnet_geographic, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/edns"
    uuid = new_resource.uuid
    client_subnet_geographic = new_resource.client_subnet_geographic

    params = { "edns": {"uuid": uuid,
        "client-subnet-geographic": client_subnet_geographic,} }

    params[:"edns"].each do |k, v|
        if not v 
            params[:"edns"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating edns') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/edns"
    uuid = new_resource.uuid
    client_subnet_geographic = new_resource.client_subnet_geographic

    params = { "edns": {"uuid": uuid,
        "client-subnet-geographic": client_subnet_geographic,} }

    params[:"edns"].each do |k, v|
        if not v
            params[:"edns"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["edns"].each do |k, v|
        if v != params[:"edns"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating edns') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/edns"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting edns') do
            client.delete(url)
        end
    end
end