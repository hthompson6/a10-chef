resource_name :a10_gslb_zone_service_dns_cname_record

property :a10_name, String, name_property: true
property :alias_name, String,required: true
property :uuid, String
property :as_backup, [true, false]
property :weight, Integer
property :sampling_enable, Array
property :admin_preference, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-cname-record/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-cname-record/%<alias-name>s"
    alias_name = new_resource.alias_name
    uuid = new_resource.uuid
    as_backup = new_resource.as_backup
    weight = new_resource.weight
    sampling_enable = new_resource.sampling_enable
    admin_preference = new_resource.admin_preference

    params = { "dns-cname-record": {"alias-name": alias_name,
        "uuid": uuid,
        "as-backup": as_backup,
        "weight": weight,
        "sampling-enable": sampling_enable,
        "admin-preference": admin_preference,} }

    params[:"dns-cname-record"].each do |k, v|
        if not v 
            params[:"dns-cname-record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-cname-record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-cname-record/%<alias-name>s"
    alias_name = new_resource.alias_name
    uuid = new_resource.uuid
    as_backup = new_resource.as_backup
    weight = new_resource.weight
    sampling_enable = new_resource.sampling_enable
    admin_preference = new_resource.admin_preference

    params = { "dns-cname-record": {"alias-name": alias_name,
        "uuid": uuid,
        "as-backup": as_backup,
        "weight": weight,
        "sampling-enable": sampling_enable,
        "admin-preference": admin_preference,} }

    params[:"dns-cname-record"].each do |k, v|
        if not v
            params[:"dns-cname-record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-cname-record"].each do |k, v|
        if v != params[:"dns-cname-record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-cname-record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-cname-record/%<alias-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-cname-record') do
            client.delete(url)
        end
    end
end