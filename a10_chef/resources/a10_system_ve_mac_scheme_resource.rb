resource_name :a10_system_ve_mac_scheme

property :a10_name, String, name_property: true
property :ve_mac_scheme_val, ['hash-based','round-robin','system-mac']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/ve-mac-scheme"
    ve_mac_scheme_val = new_resource.ve_mac_scheme_val
    uuid = new_resource.uuid

    params = { "ve-mac-scheme": {"ve-mac-scheme-val": ve_mac_scheme_val,
        "uuid": uuid,} }

    params[:"ve-mac-scheme"].each do |k, v|
        if not v 
            params[:"ve-mac-scheme"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ve-mac-scheme') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ve-mac-scheme"
    ve_mac_scheme_val = new_resource.ve_mac_scheme_val
    uuid = new_resource.uuid

    params = { "ve-mac-scheme": {"ve-mac-scheme-val": ve_mac_scheme_val,
        "uuid": uuid,} }

    params[:"ve-mac-scheme"].each do |k, v|
        if not v
            params[:"ve-mac-scheme"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ve-mac-scheme"].each do |k, v|
        if v != params[:"ve-mac-scheme"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ve-mac-scheme') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ve-mac-scheme"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ve-mac-scheme') do
            client.delete(url)
        end
    end
end