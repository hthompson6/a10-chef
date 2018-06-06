resource_name :a10_slb_template_diameter_origin_host

property :a10_name, String, name_property: true
property :uuid, String
property :origin_host_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/diameter/%<name>s/"
    get_url = "/axapi/v3/slb/template/diameter/%<name>s/origin-host"
    uuid = new_resource.uuid
    origin_host_name = new_resource.origin_host_name

    params = { "origin-host": {"uuid": uuid,
        "origin-host-name": origin_host_name,} }

    params[:"origin-host"].each do |k, v|
        if not v 
            params[:"origin-host"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating origin-host') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/diameter/%<name>s/origin-host"
    uuid = new_resource.uuid
    origin_host_name = new_resource.origin_host_name

    params = { "origin-host": {"uuid": uuid,
        "origin-host-name": origin_host_name,} }

    params[:"origin-host"].each do |k, v|
        if not v
            params[:"origin-host"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["origin-host"].each do |k, v|
        if v != params[:"origin-host"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating origin-host') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/diameter/%<name>s/origin-host"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting origin-host') do
            client.delete(url)
        end
    end
end