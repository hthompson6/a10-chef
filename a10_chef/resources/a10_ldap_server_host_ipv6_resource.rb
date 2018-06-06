resource_name :a10_ldap_server_host_ipv6

property :a10_name, String, name_property: true
property :domain, String
property :group, String
property :uuid, String
property :cn_value, String
property :ipv6_addr, String,required: true
property :port_cfg, Hash
property :dn_value, String
property :base, String
property :domain_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ldap-server/host/ipv6/"
    get_url = "/axapi/v3/ldap-server/host/ipv6/%<ipv6-addr>s"
    domain = new_resource.domain
    group = new_resource.group
    uuid = new_resource.uuid
    cn_value = new_resource.cn_value
    ipv6_addr = new_resource.ipv6_addr
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ipv6": {"domain": domain,
        "group": group,
        "uuid": uuid,
        "cn-value": cn_value,
        "ipv6-addr": ipv6_addr,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ipv6/%<ipv6-addr>s"
    domain = new_resource.domain
    group = new_resource.group
    uuid = new_resource.uuid
    cn_value = new_resource.cn_value
    ipv6_addr = new_resource.ipv6_addr
    port_cfg = new_resource.port_cfg
    dn_value = new_resource.dn_value
    base = new_resource.base
    domain_cfg = new_resource.domain_cfg

    params = { "ipv6": {"domain": domain,
        "group": group,
        "uuid": uuid,
        "cn-value": cn_value,
        "ipv6-addr": ipv6_addr,
        "port-cfg": port_cfg,
        "dn-value": dn_value,
        "base": base,
        "domain-cfg": domain_cfg,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ldap-server/host/ipv6/%<ipv6-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end