resource_name :a10_ldap_server_host_ipv4

property :a10_name, String, name_property: true
property :domain, String
property :group, String
property :uuid, String
property :ipv4_addr, String,required: true
property :cn_value, String
property :port_cfg, Hash
property :dn_value, String
property :base, String
property :domain_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ldap-server/host/ipv4/"
    get_url = "/axapi/v3/ldap-server/host/ipv4/%<ipv4-addr>s"
    domain = new_resource.domain
    group = new_resource.group
    uuid = new_resource.uuid
    ipv4_addr = new_resource.ipv4_addr
    cn_value = new_resource.cn_value
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ipv4": {"domain": domain,
        "group": group,
        "uuid": uuid,
        "ipv4-addr": ipv4_addr,
        "cn-value": cn_value,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ipv4"].each do |k, v|
        if not v 
            params[:"ipv4"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ipv4/%<ipv4-addr>s"
    domain = new_resource.domain
    group = new_resource.group
    uuid = new_resource.uuid
    ipv4_addr = new_resource.ipv4_addr
    cn_value = new_resource.cn_value
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ipv4": {"domain": domain,
        "group": group,
        "uuid": uuid,
        "ipv4-addr": ipv4_addr,
        "cn-value": cn_value,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ipv4"].each do |k, v|
        if not v
            params[:"ipv4"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4"].each do |k, v|
        if v != params[:"ipv4"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ipv4/%<ipv4-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4') do
            client.delete(url)
        end
    end
end