resource_name :a10_slb_template_persist_destination_ip

property :a10_name, String, name_property: true
property :netmask6, Integer
property :hash_persist, [true, false]
property :dont_honor_conn_rules, [true, false]
property :service_group, [true, false]
property :user_tag, String
property :server, [true, false]
property :netmask, String
property :timeout, Integer
property :scan_all_members, [true, false]
property :match_type, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/persist/destination-ip/"
    get_url = "/axapi/v3/slb/template/persist/destination-ip/%<name>s"
    netmask6 = new_resource.netmask6
    hash_persist = new_resource.hash_persist
    a10_name = new_resource.a10_name
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    service_group = new_resource.service_group
    user_tag = new_resource.user_tag
    server = new_resource.server
    netmask = new_resource.netmask
    timeout = new_resource.timeout
    scan_all_members = new_resource.scan_all_members
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "destination-ip": {"netmask6": netmask6,
        "hash-persist": hash_persist,
        "name": a10_name,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "service-group": service_group,
        "user-tag": user_tag,
        "server": server,
        "netmask": netmask,
        "timeout": timeout,
        "scan-all-members": scan_all_members,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"destination-ip"].each do |k, v|
        if not v 
            params[:"destination-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating destination-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/destination-ip/%<name>s"
    netmask6 = new_resource.netmask6
    hash_persist = new_resource.hash_persist
    a10_name = new_resource.a10_name
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    service_group = new_resource.service_group
    user_tag = new_resource.user_tag
    server = new_resource.server
    netmask = new_resource.netmask
    timeout = new_resource.timeout
    scan_all_members = new_resource.scan_all_members
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "destination-ip": {"netmask6": netmask6,
        "hash-persist": hash_persist,
        "name": a10_name,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "service-group": service_group,
        "user-tag": user_tag,
        "server": server,
        "netmask": netmask,
        "timeout": timeout,
        "scan-all-members": scan_all_members,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"destination-ip"].each do |k, v|
        if not v
            params[:"destination-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["destination-ip"].each do |k, v|
        if v != params[:"destination-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating destination-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/destination-ip/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting destination-ip') do
            client.delete(url)
        end
    end
end