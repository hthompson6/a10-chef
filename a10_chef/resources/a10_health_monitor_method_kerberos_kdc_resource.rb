resource_name :a10_health_monitor_method_kerberos_kdc

property :a10_name, String, name_property: true
property :kerberos_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/kerberos-kdc"
    kerberos_cfg = new_resource.kerberos_cfg
    uuid = new_resource.uuid

    params = { "kerberos-kdc": {"kerberos-cfg": kerberos_cfg,
        "uuid": uuid,} }

    params[:"kerberos-kdc"].each do |k, v|
        if not v 
            params[:"kerberos-kdc"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating kerberos-kdc') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/kerberos-kdc"
    kerberos_cfg = new_resource.kerberos_cfg
    uuid = new_resource.uuid

    params = { "kerberos-kdc": {"kerberos-cfg": kerberos_cfg,
        "uuid": uuid,} }

    params[:"kerberos-kdc"].each do |k, v|
        if not v
            params[:"kerberos-kdc"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["kerberos-kdc"].each do |k, v|
        if v != params[:"kerberos-kdc"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating kerberos-kdc') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/kerberos-kdc"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting kerberos-kdc') do
            client.delete(url)
        end
    end
end