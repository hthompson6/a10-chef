resource_name :a10_dnssec_ds

property :a10_name, String, name_property: true
property :ds_delete, [true, false]
property :zone_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/dnssec/"
    get_url = "/axapi/v3/dnssec/ds"
    ds_delete = new_resource.ds_delete
    zone_name = new_resource.zone_name

    params = { "ds": {"ds-delete": ds_delete,
        "zone-name": zone_name,} }

    params[:"ds"].each do |k, v|
        if not v 
            params[:"ds"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ds') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/ds"
    ds_delete = new_resource.ds_delete
    zone_name = new_resource.zone_name

    params = { "ds": {"ds-delete": ds_delete,
        "zone-name": zone_name,} }

    params[:"ds"].each do |k, v|
        if not v
            params[:"ds"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ds"].each do |k, v|
        if v != params[:"ds"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ds') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/ds"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ds') do
            client.delete(url)
        end
    end
end