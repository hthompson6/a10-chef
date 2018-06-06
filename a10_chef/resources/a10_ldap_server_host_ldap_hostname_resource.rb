resource_name :a10_ldap_server_host_ldap_hostname

property :a10_name, String, name_property: true
property :domain, String
property :hostname, String,required: true
property :group, String
property :uuid, String
property :cn_value, String
property :port_cfg, Hash
property :dn_value, String
property :base, String
property :domain_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ldap-server/host/ldap-hostname/"
    get_url = "/axapi/v3/ldap-server/host/ldap-hostname/%<hostname>s"
    domain = new_resource.domain
    hostname = new_resource.hostname
    group = new_resource.group
    uuid = new_resource.uuid
    cn_value = new_resource.cn_value
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ldap-hostname": {"domain": domain,
        "hostname": hostname,
        "group": group,
        "uuid": uuid,
        "cn-value": cn_value,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ldap-hostname"].each do |k, v|
        if not v 
            params[:"ldap-hostname"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ldap-hostname') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ldap-hostname/%<hostname>s"
    domain = new_resource.domain
    hostname = new_resource.hostname
    group = new_resource.group
    uuid = new_resource.uuid
    cn_value = new_resource.cn_value
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ldap-hostname": {"domain": domain,
        "hostname": hostname,
        "group": group,
        "uuid": uuid,
        "cn-value": cn_value,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ldap-hostname"].each do |k, v|
        if not v
            params[:"ldap-hostname"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ldap-hostname"].each do |k, v|
        if v != params[:"ldap-hostname"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ldap-hostname') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ldap-hostname/%<hostname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ldap-hostname') do
            client.delete(url)
        end
    end
end