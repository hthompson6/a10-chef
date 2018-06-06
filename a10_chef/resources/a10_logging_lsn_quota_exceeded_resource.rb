resource_name :a10_logging_lsn_quota_exceeded

property :a10_name, String, name_property: true
property :with_radius_attribute, [true, false]
property :msisdn, [true, false]
property :custom1, [true, false]
property :custom2, [true, false]
property :custom3, [true, false]
property :disable_pool_based, [true, false]
property :imei, [true, false]
property :ip_based, [true, false]
property :imsi, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/lsn/"
    get_url = "/axapi/v3/logging/lsn/quota-exceeded"
    with_radius_attribute = new_resource.with_radius_attribute
    msisdn = new_resource.msisdn
    custom1 = new_resource.custom1
    custom2 = new_resource.custom2
    custom3 = new_resource.custom3
    disable_pool_based = new_resource.disable_pool_based
    imei = new_resource.imei
    ip_based = new_resource.ip_based
    imsi = new_resource.imsi
    uuid = new_resource.uuid

    params = { "quota-exceeded": {"with-radius-attribute": with_radius_attribute,
        "msisdn": msisdn,
        "custom1": custom1,
        "custom2": custom2,
        "custom3": custom3,
        "disable-pool-based": disable_pool_based,
        "imei": imei,
        "ip-based": ip_based,
        "imsi": imsi,
        "uuid": uuid,} }

    params[:"quota-exceeded"].each do |k, v|
        if not v 
            params[:"quota-exceeded"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating quota-exceeded') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/lsn/quota-exceeded"
    with_radius_attribute = new_resource.with_radius_attribute
    msisdn = new_resource.msisdn
    custom1 = new_resource.custom1
    custom2 = new_resource.custom2
    custom3 = new_resource.custom3
    disable_pool_based = new_resource.disable_pool_based
    imei = new_resource.imei
    ip_based = new_resource.ip_based
    imsi = new_resource.imsi
    uuid = new_resource.uuid

    params = { "quota-exceeded": {"with-radius-attribute": with_radius_attribute,
        "msisdn": msisdn,
        "custom1": custom1,
        "custom2": custom2,
        "custom3": custom3,
        "disable-pool-based": disable_pool_based,
        "imei": imei,
        "ip-based": ip_based,
        "imsi": imsi,
        "uuid": uuid,} }

    params[:"quota-exceeded"].each do |k, v|
        if not v
            params[:"quota-exceeded"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["quota-exceeded"].each do |k, v|
        if v != params[:"quota-exceeded"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating quota-exceeded') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/lsn/quota-exceeded"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting quota-exceeded') do
            client.delete(url)
        end
    end
end