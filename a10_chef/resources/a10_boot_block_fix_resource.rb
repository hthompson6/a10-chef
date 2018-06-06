resource_name :a10_boot_block_fix

property :a10_name, String, name_property: true
property :cf, [true, false]
property :hd, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/boot-block-fix"
    cf = new_resource.cf
    hd = new_resource.hd

    params = { "boot-block-fix": {"cf": cf,
        "hd": hd,} }

    params[:"boot-block-fix"].each do |k, v|
        if not v 
            params[:"boot-block-fix"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating boot-block-fix') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/boot-block-fix"
    cf = new_resource.cf
    hd = new_resource.hd

    params = { "boot-block-fix": {"cf": cf,
        "hd": hd,} }

    params[:"boot-block-fix"].each do |k, v|
        if not v
            params[:"boot-block-fix"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["boot-block-fix"].each do |k, v|
        if v != params[:"boot-block-fix"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating boot-block-fix') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/boot-block-fix"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting boot-block-fix') do
            client.delete(url)
        end
    end
end