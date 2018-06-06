resource_name :a10_slb_template_persist_source_ip

property :a10_name, String, name_property: true
property :netmask6, Integer
property :incl_dst_ip, [true, false]
property :hash_persist, [true, false]
property :enforce_higher_priority, [true, false]
property :dont_honor_conn_rules, [true, false]
property :primary_port, Integer
property :user_tag, String
property :server, [true, false]
property :service_group, [true, false]
property :timeout, Integer
property :scan_all_members, [true, false]
property :netmask, String
property :incl_sport, [true, false]
property :match_type, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/persist/source-ip/"
    get_url = "/axapi/v3/slb/template/persist/source-ip/%<name>s"
    netmask6 = new_resource.netmask6
    incl_dst_ip = new_resource.incl_dst_ip
    hash_persist = new_resource.hash_persist
    a10_name = new_resource.a10_name
    enforce_higher_priority = new_resource.enforce_higher_priority
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    primary_port = new_resource.primary_port
    user_tag = new_resource.user_tag
    server = new_resource.server
    service_group = new_resource.service_group
    timeout = new_resource.timeout
    scan_all_members = new_resource.scan_all_members
    netmask = new_resource.netmask
    incl_sport = new_resource.incl_sport
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "source-ip": {"netmask6": netmask6,
        "incl-dst-ip": incl_dst_ip,
        "hash-persist": hash_persist,
        "name": a10_name,
        "enforce-higher-priority": enforce_higher_priority,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "primary-port": primary_port,
        "user-tag": user_tag,
        "server": server,
        "service-group": service_group,
        "timeout": timeout,
        "scan-all-members": scan_all_members,
        "netmask": netmask,
        "incl-sport": incl_sport,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"source-ip"].each do |k, v|
        if not v 
            params[:"source-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating source-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/source-ip/%<name>s"
    netmask6 = new_resource.netmask6
    incl_dst_ip = new_resource.incl_dst_ip
    hash_persist = new_resource.hash_persist
    a10_name = new_resource.a10_name
    enforce_higher_priority = new_resource.enforce_higher_priority
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    primary_port = new_resource.primary_port
    user_tag = new_resource.user_tag
    server = new_resource.server
    service_group = new_resource.service_group
    timeout = new_resource.timeout
    scan_all_members = new_resource.scan_all_members
    netmask = new_resource.netmask
    incl_sport = new_resource.incl_sport
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "source-ip": {"netmask6": netmask6,
        "incl-dst-ip": incl_dst_ip,
        "hash-persist": hash_persist,
        "name": a10_name,
        "enforce-higher-priority": enforce_higher_priority,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "primary-port": primary_port,
        "user-tag": user_tag,
        "server": server,
        "service-group": service_group,
        "timeout": timeout,
        "scan-all-members": scan_all_members,
        "netmask": netmask,
        "incl-sport": incl_sport,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"source-ip"].each do |k, v|
        if not v
            params[:"source-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["source-ip"].each do |k, v|
        if v != params[:"source-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating source-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/source-ip/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting source-ip') do
            client.delete(url)
        end
    end
end