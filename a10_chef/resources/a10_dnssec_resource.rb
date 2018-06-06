resource_name :a10_dnssec

property :a10_name, String, name_property: true
property :key_rollover, Hash
property :standalone, [true, false]
property :sign_zone_now, Hash
property :dnskey, Hash
property :template_list, Array
property :ds, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/dnssec"
    key_rollover = new_resource.key_rollover
    standalone = new_resource.standalone
    sign_zone_now = new_resource.sign_zone_now
    dnskey = new_resource.dnskey
    template_list = new_resource.template_list
    ds = new_resource.ds
    uuid = new_resource.uuid

    params = { "dnssec": {"key-rollover": key_rollover,
        "standalone": standalone,
        "sign-zone-now": sign_zone_now,
        "dnskey": dnskey,
        "template-list": template_list,
        "ds": ds,
        "uuid": uuid,} }

    params[:"dnssec"].each do |k, v|
        if not v 
            params[:"dnssec"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dnssec') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec"
    key_rollover = new_resource.key_rollover
    standalone = new_resource.standalone
    sign_zone_now = new_resource.sign_zone_now
    dnskey = new_resource.dnskey
    template_list = new_resource.template_list
    ds = new_resource.ds
    uuid = new_resource.uuid

    params = { "dnssec": {"key-rollover": key_rollover,
        "standalone": standalone,
        "sign-zone-now": sign_zone_now,
        "dnskey": dnskey,
        "template-list": template_list,
        "ds": ds,
        "uuid": uuid,} }

    params[:"dnssec"].each do |k, v|
        if not v
            params[:"dnssec"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dnssec"].each do |k, v|
        if v != params[:"dnssec"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dnssec') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dnssec') do
            client.delete(url)
        end
    end
end