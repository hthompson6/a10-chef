resource_name :a10_gslb_zone_service_dns_a_record_dns_a_record_srv

property :a10_name, String, name_property: true
property :as_backup, [true, false]
property :as_replace, [true, false]
property :uuid, String
property :weight, Integer
property :svrname, String,required: true
property :sampling_enable, Array
property :disable, [true, false]
property :static, [true, false]
property :ttl, Integer
property :admin_ip, Integer
property :no_resp, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-srv/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-srv/%<svrname>s"
    as_backup = new_resource.as_backup
    as_replace = new_resource.as_replace
    uuid = new_resource.uuid
    weight = new_resource.weight
    svrname = new_resource.svrname
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    static = new_resource.static
    ttl = new_resource.ttl
    admin_ip = new_resource.admin_ip
    no_resp = new_resource.no_resp

    params = { "dns-a-record-srv": {"as-backup": as_backup,
        "as-replace": as_replace,
        "uuid": uuid,
        "weight": weight,
        "svrname": svrname,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "static": static,
        "ttl": ttl,
        "admin-ip": admin_ip,
        "no-resp": no_resp,} }

    params[:"dns-a-record-srv"].each do |k, v|
        if not v 
            params[:"dns-a-record-srv"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns-a-record-srv') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-srv/%<svrname>s"
    as_backup = new_resource.as_backup
    as_replace = new_resource.as_replace
    uuid = new_resource.uuid
    weight = new_resource.weight
    svrname = new_resource.svrname
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    static = new_resource.static
    ttl = new_resource.ttl
    admin_ip = new_resource.admin_ip
    no_resp = new_resource.no_resp

    params = { "dns-a-record-srv": {"as-backup": as_backup,
        "as-replace": as_replace,
        "uuid": uuid,
        "weight": weight,
        "svrname": svrname,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "static": static,
        "ttl": ttl,
        "admin-ip": admin_ip,
        "no-resp": no_resp,} }

    params[:"dns-a-record-srv"].each do |k, v|
        if not v
            params[:"dns-a-record-srv"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns-a-record-srv"].each do |k, v|
        if v != params[:"dns-a-record-srv"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns-a-record-srv') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/dns-a-record/dns-a-record-srv/%<svrname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns-a-record-srv') do
            client.delete(url)
        end
    end
end