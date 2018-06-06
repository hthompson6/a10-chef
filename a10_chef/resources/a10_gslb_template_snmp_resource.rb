resource_name :a10_gslb_template_snmp

property :a10_name, String, name_property: true
property :username, String
property :oid, String
property :priv_proto, ['aes','des']
property :uuid, String
property :context_name, String
property :auth_key, String
property :interval, Integer
property :context_engine_id, String
property :security_level, ['no-auth','auth-no-priv','auth-priv']
property :community, String
property :auth_proto, ['sha','md5']
property :host, String
property :version, ['v1','v2c','v3']
property :user_tag, String
property :interface, Integer
property :priv_key, String
property :security_engine_id, String
property :port, Integer
property :snmp_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/template/snmp/"
    get_url = "/axapi/v3/gslb/template/snmp/%<snmp-name>s"
    username = new_resource.username
    oid = new_resource.oid
    priv_proto = new_resource.priv_proto
    uuid = new_resource.uuid
    context_name = new_resource.context_name
    auth_key = new_resource.auth_key
    interval = new_resource.interval
    context_engine_id = new_resource.context_engine_id
    security_level = new_resource.security_level
    community = new_resource.community
    auth_proto = new_resource.auth_proto
    host = new_resource.host
    version = new_resource.version
    user_tag = new_resource.user_tag
    interface = new_resource.interface
    priv_key = new_resource.priv_key
    security_engine_id = new_resource.security_engine_id
    port = new_resource.port
    snmp_name = new_resource.snmp_name

    params = { "snmp": {"username": username,
        "oid": oid,
        "priv-proto": priv_proto,
        "uuid": uuid,
        "context-name": context_name,
        "auth-key": auth_key,
        "interval": interval,
        "context-engine-id": context_engine_id,
        "security-level": security_level,
        "community": community,
        "auth-proto": auth_proto,
        "host": host,
        "version": version,
        "user-tag": user_tag,
        "interface": interface,
        "priv-key": priv_key,
        "security-engine-id": security_engine_id,
        "port": port,
        "snmp-name": snmp_name,} }

    params[:"snmp"].each do |k, v|
        if not v 
            params[:"snmp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating snmp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/template/snmp/%<snmp-name>s"
    username = new_resource.username
    oid = new_resource.oid
    priv_proto = new_resource.priv_proto
    uuid = new_resource.uuid
    context_name = new_resource.context_name
    auth_key = new_resource.auth_key
    interval = new_resource.interval
    context_engine_id = new_resource.context_engine_id
    security_level = new_resource.security_level
    community = new_resource.community
    auth_proto = new_resource.auth_proto
    host = new_resource.host
    version = new_resource.version
    user_tag = new_resource.user_tag
    interface = new_resource.interface
    priv_key = new_resource.priv_key
    security_engine_id = new_resource.security_engine_id
    port = new_resource.port
    snmp_name = new_resource.snmp_name

    params = { "snmp": {"username": username,
        "oid": oid,
        "priv-proto": priv_proto,
        "uuid": uuid,
        "context-name": context_name,
        "auth-key": auth_key,
        "interval": interval,
        "context-engine-id": context_engine_id,
        "security-level": security_level,
        "community": community,
        "auth-proto": auth_proto,
        "host": host,
        "version": version,
        "user-tag": user_tag,
        "interface": interface,
        "priv-key": priv_key,
        "security-engine-id": security_engine_id,
        "port": port,
        "snmp-name": snmp_name,} }

    params[:"snmp"].each do |k, v|
        if not v
            params[:"snmp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["snmp"].each do |k, v|
        if v != params[:"snmp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating snmp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/template/snmp/%<snmp-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting snmp') do
            client.delete(url)
        end
    end
end