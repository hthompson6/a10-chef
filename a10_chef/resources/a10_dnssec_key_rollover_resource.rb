resource_name :a10_dnssec_key_rollover

property :a10_name, String, name_property: true
property :dnssec_key_type, ['ZSK','KSK']
property :zsk_start, [true, false]
property :ksk_start, [true, false]
property :ds_ready_in_parent_zone, [true, false]
property :zone_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/dnssec/"
    get_url = "/axapi/v3/dnssec/key-rollover"
    dnssec_key_type = new_resource.dnssec_key_type
    zsk_start = new_resource.zsk_start
    ksk_start = new_resource.ksk_start
    ds_ready_in_parent_zone = new_resource.ds_ready_in_parent_zone
    zone_name = new_resource.zone_name

    params = { "key-rollover": {"dnssec-key-type": dnssec_key_type,
        "zsk-start": zsk_start,
        "ksk-start": ksk_start,
        "ds-ready-in-parent-zone": ds_ready_in_parent_zone,
        "zone-name": zone_name,} }

    params[:"key-rollover"].each do |k, v|
        if not v 
            params[:"key-rollover"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating key-rollover') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/key-rollover"
    dnssec_key_type = new_resource.dnssec_key_type
    zsk_start = new_resource.zsk_start
    ksk_start = new_resource.ksk_start
    ds_ready_in_parent_zone = new_resource.ds_ready_in_parent_zone
    zone_name = new_resource.zone_name

    params = { "key-rollover": {"dnssec-key-type": dnssec_key_type,
        "zsk-start": zsk_start,
        "ksk-start": ksk_start,
        "ds-ready-in-parent-zone": ds_ready_in_parent_zone,
        "zone-name": zone_name,} }

    params[:"key-rollover"].each do |k, v|
        if not v
            params[:"key-rollover"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["key-rollover"].each do |k, v|
        if v != params[:"key-rollover"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating key-rollover') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/key-rollover"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting key-rollover') do
            client.delete(url)
        end
    end
end