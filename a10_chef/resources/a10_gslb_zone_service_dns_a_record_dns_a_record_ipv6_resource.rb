resource_name :a10_gslb_zone_service_dns_a_record_dns_a_record_ipv6

property :a10_name, String, name_property: true
property :as_replace, [true, false]
property :dns_a_record_ipv6, String,required: true
property :as_backup, [true, false]
property :weight, Integer
property :sampling_enable, Array
property :disable, [true, false]
property :static, [true, false]
property :ttl, Integer
property :no_resp, [true, false]
property :admin_ip, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-ipv6/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-ipv6/%<dns-a-record-ipv6>s"
    as_replace = new_resource.as_replace
    dns_a_record_ipv6 = new_resource.dns_a_record_ipv6
    as_backup = new_resource.as_backup
    weight = new_resource.weight
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    static = new_resource.static
    ttl = new_resource.ttl
    no_resp = new_resource.no_resp
    admin_ip = new_resource.admin_ip
    uuid = new_resource.uuid

    params = { "dns-a-record-ipv6": {"as-replace": as_replace,
        "dns-a-record-ipv6": dns_a_record_ipv6,
        "as-backup": as_backup,
        "weight": weight,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "static": static,
        "ttl": ttl,
        "no-resp": no_resp,
        "admin-ip": admin_ip,
        "uuid": uuid,} }

    params[:"dns-a-record-ipv6"].each do |k, v|
        if not v 
            params[:"dns-a-record-ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-a-record-ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-ipv6/%<dns-a-record-ipv6>s"
    as_replace = new_resource.as_replace
    dns_a_record_ipv6 = new_resource.dns_a_record_ipv6
    as_backup = new_resource.as_backup
    weight = new_resource.weight
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    static = new_resource.static
    ttl = new_resource.ttl
    no_resp = new_resource.no_resp
    admin_ip = new_resource.admin_ip
    uuid = new_resource.uuid

    params = { "dns-a-record-ipv6": {"as-replace": as_replace,
        "dns-a-record-ipv6": dns_a_record_ipv6,
        "as-backup": as_backup,
        "weight": weight,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "static": static,
        "ttl": ttl,
        "no-resp": no_resp,
        "admin-ip": admin_ip,
        "uuid": uuid,} }

    params[:"dns-a-record-ipv6"].each do |k, v|
        if not v
            params[:"dns-a-record-ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-a-record-ipv6"].each do |k, v|
        if v != params[:"dns-a-record-ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-a-record-ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-ipv6/%<dns-a-record-ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-a-record-ipv6') do
            client.delete(url)
        end
    end
end