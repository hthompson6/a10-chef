resource_name :a10_health_monitor_method_sip

property :a10_name, String, name_property: true
property :sip, [true, false]
property :uuid, String
property :register, [true, false]
property :expect_response_code, String
property :sip_port, Integer
property :sip_tcp, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/sip"
    sip = new_resource.sip
    uuid = new_resource.uuid
    register = new_resource.register
    expect_response_code = new_resource.expect_response_code
    sip_port = new_resource.sip_port
    sip_tcp = new_resource.sip_tcp

    params = { "sip": {"sip": sip,
        "uuid": uuid,
        "register": register,
        "expect-response-code": expect_response_code,
        "sip-port": sip_port,
        "sip-tcp": sip_tcp,} }

    params[:"sip"].each do |k, v|
        if not v 
            params[:"sip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/sip"
    sip = new_resource.sip
    uuid = new_resource.uuid
    register = new_resource.register
    expect_response_code = new_resource.expect_response_code
    sip_port = new_resource.sip_port
    sip_tcp = new_resource.sip_tcp

    params = { "sip": {"sip": sip,
        "uuid": uuid,
        "register": register,
        "expect-response-code": expect_response_code,
        "sip-port": sip_port,
        "sip-tcp": sip_tcp,} }

    params[:"sip"].each do |k, v|
        if not v
            params[:"sip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sip"].each do |k, v|
        if v != params[:"sip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/sip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sip') do
            client.delete(url)
        end
    end
end