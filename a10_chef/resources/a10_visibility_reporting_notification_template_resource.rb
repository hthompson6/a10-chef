resource_name :a10_visibility_reporting_notification_template

property :a10_name, String, name_property: true
property :protocol, ['http','https']
property :use_mgmt_port, [true, false]
property :user_tag, String
property :relative_uri, String
property :authentication, Hash
property :host_name, String
property :ipv6_address, String
property :a10_action, ['enable','disable']
property :ipv4_address, String
property :port, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/reporting/notification-template/"
    get_url = "/axapi/v3/visibility/reporting/notification-template/%<name>s"
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    use_mgmt_port = new_resource.use_mgmt_port
    user_tag = new_resource.user_tag
    relative_uri = new_resource.relative_uri
    authentication = new_resource.authentication
    host_name = new_resource.host_name
    ipv6_address = new_resource.ipv6_address
    a10_name = new_resource.a10_name
    ipv4_address = new_resource.ipv4_address
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "notification-template": {"protocol": protocol,
        "name": a10_name,
        "use-mgmt-port": use_mgmt_port,
        "user-tag": user_tag,
        "relative-uri": relative_uri,
        "authentication": authentication,
        "host-name": host_name,
        "ipv6-address": ipv6_address,
        "action": a10_action,
        "ipv4-address": ipv4_address,
        "port": port,
        "uuid": uuid,} }

    params[:"notification-template"].each do |k, v|
        if not v 
            params[:"notification-template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating notification-template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting/notification-template/%<name>s"
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    use_mgmt_port = new_resource.use_mgmt_port
    user_tag = new_resource.user_tag
    relative_uri = new_resource.relative_uri
    authentication = new_resource.authentication
    host_name = new_resource.host_name
    ipv6_address = new_resource.ipv6_address
    a10_name = new_resource.a10_name
    ipv4_address = new_resource.ipv4_address
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "notification-template": {"protocol": protocol,
        "name": a10_name,
        "use-mgmt-port": use_mgmt_port,
        "user-tag": user_tag,
        "relative-uri": relative_uri,
        "authentication": authentication,
        "host-name": host_name,
        "ipv6-address": ipv6_address,
        "action": a10_action,
        "ipv4-address": ipv4_address,
        "port": port,
        "uuid": uuid,} }

    params[:"notification-template"].each do |k, v|
        if not v
            params[:"notification-template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["notification-template"].each do |k, v|
        if v != params[:"notification-template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating notification-template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting/notification-template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting notification-template') do
            client.delete(url)
        end
    end
end