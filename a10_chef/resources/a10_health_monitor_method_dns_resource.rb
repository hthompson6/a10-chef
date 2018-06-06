resource_name :a10_health_monitor_method_dns

property :a10_name, String, name_property: true
property :dns_domain_type, ['A','CNAME','SOA','PTR','MX','TXT','AAAA']
property :dns_ipv4_recurse, ['enabled','disabled']
property :uuid, String
property :dns_ipv6_port, Integer
property :dns_ipv4_addr, String
property :dns_domain_expect, Hash
property :dns_ipv4_expect, Hash
property :dns_ipv4_port, Integer
property :dns_ipv6_expect, Hash
property :dns_ip_key, [true, false]
property :dns_ipv6_recurse, ['enabled','disabled']
property :dns_ipv6_tcp, [true, false]
property :dns_domain_recurse, ['enabled','disabled']
property :dns_domain_tcp, [true, false]
property :dns, [true, false]
property :dns_ipv4_tcp, [true, false]
property :dns_domain, String
property :dns_ipv6_addr, String
property :dns_domain_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/dns"
    dns_domain_type = new_resource.dns_domain_type
    dns_ipv4_recurse = new_resource.dns_ipv4_recurse
    uuid = new_resource.uuid
    dns_ipv6_port = new_resource.dns_ipv6_port
    dns_ipv4_addr = new_resource.dns_ipv4_addr
    dns_domain_expect = new_resource.dns_domain_expect
    dns_ipv4_expect = new_resource.dns_ipv4_expect
    dns_ipv4_port = new_resource.dns_ipv4_port
    dns_ipv6_expect = new_resource.dns_ipv6_expect
    dns_ip_key = new_resource.dns_ip_key
    dns_ipv6_recurse = new_resource.dns_ipv6_recurse
    dns_ipv6_tcp = new_resource.dns_ipv6_tcp
    dns_domain_recurse = new_resource.dns_domain_recurse
    dns_domain_tcp = new_resource.dns_domain_tcp
    dns = new_resource.dns
    dns_ipv4_tcp = new_resource.dns_ipv4_tcp
    dns_domain = new_resource.dns_domain
    dns_ipv6_addr = new_resource.dns_ipv6_addr
    dns_domain_port = new_resource.dns_domain_port

    params = { "dns": {"dns-domain-type": dns_domain_type,
        "dns-ipv4-recurse": dns_ipv4_recurse,
        "uuid": uuid,
        "dns-ipv6-port": dns_ipv6_port,
        "dns-ipv4-addr": dns_ipv4_addr,
        "dns-domain-expect": dns_domain_expect,
        "dns-ipv4-expect": dns_ipv4_expect,
        "dns-ipv4-port": dns_ipv4_port,
        "dns-ipv6-expect": dns_ipv6_expect,
        "dns-ip-key": dns_ip_key,
        "dns-ipv6-recurse": dns_ipv6_recurse,
        "dns-ipv6-tcp": dns_ipv6_tcp,
        "dns-domain-recurse": dns_domain_recurse,
        "dns-domain-tcp": dns_domain_tcp,
        "dns": dns,
        "dns-ipv4-tcp": dns_ipv4_tcp,
        "dns-domain": dns_domain,
        "dns-ipv6-addr": dns_ipv6_addr,
        "dns-domain-port": dns_domain_port,} }

    params[:"dns"].each do |k, v|
        if not v 
            params[:"dns"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/dns"
    dns_domain_type = new_resource.dns_domain_type
    dns_ipv4_recurse = new_resource.dns_ipv4_recurse
    uuid = new_resource.uuid
    dns_ipv6_port = new_resource.dns_ipv6_port
    dns_ipv4_addr = new_resource.dns_ipv4_addr
    dns_domain_expect = new_resource.dns_domain_expect
    dns_ipv4_expect = new_resource.dns_ipv4_expect
    dns_ipv4_port = new_resource.dns_ipv4_port
    dns_ipv6_expect = new_resource.dns_ipv6_expect
    dns_ip_key = new_resource.dns_ip_key
    dns_ipv6_recurse = new_resource.dns_ipv6_recurse
    dns_ipv6_tcp = new_resource.dns_ipv6_tcp
    dns_domain_recurse = new_resource.dns_domain_recurse
    dns_domain_tcp = new_resource.dns_domain_tcp
    dns = new_resource.dns
    dns_ipv4_tcp = new_resource.dns_ipv4_tcp
    dns_domain = new_resource.dns_domain
    dns_ipv6_addr = new_resource.dns_ipv6_addr
    dns_domain_port = new_resource.dns_domain_port

    params = { "dns": {"dns-domain-type": dns_domain_type,
        "dns-ipv4-recurse": dns_ipv4_recurse,
        "uuid": uuid,
        "dns-ipv6-port": dns_ipv6_port,
        "dns-ipv4-addr": dns_ipv4_addr,
        "dns-domain-expect": dns_domain_expect,
        "dns-ipv4-expect": dns_ipv4_expect,
        "dns-ipv4-port": dns_ipv4_port,
        "dns-ipv6-expect": dns_ipv6_expect,
        "dns-ip-key": dns_ip_key,
        "dns-ipv6-recurse": dns_ipv6_recurse,
        "dns-ipv6-tcp": dns_ipv6_tcp,
        "dns-domain-recurse": dns_domain_recurse,
        "dns-domain-tcp": dns_domain_tcp,
        "dns": dns,
        "dns-ipv4-tcp": dns_ipv4_tcp,
        "dns-domain": dns_domain,
        "dns-ipv6-addr": dns_ipv6_addr,
        "dns-domain-port": dns_domain_port,} }

    params[:"dns"].each do |k, v|
        if not v
            params[:"dns"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns"].each do |k, v|
        if v != params[:"dns"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/dns"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns') do
            client.delete(url)
        end
    end
end