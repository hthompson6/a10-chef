resource_name :a10_health_monitor_method_external

property :a10_name, String, name_property: true
property :ext_program, String
property :ext_preference, [true, false]
property :ext_arguments, String
property :uuid, String
property :external, [true, false]
property :ext_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/external"
    ext_program = new_resource.ext_program
    ext_preference = new_resource.ext_preference
    ext_arguments = new_resource.ext_arguments
    uuid = new_resource.uuid
    external = new_resource.external
    ext_port = new_resource.ext_port

    params = { "external": {"ext-program": ext_program,
        "ext-preference": ext_preference,
        "ext-arguments": ext_arguments,
        "uuid": uuid,
        "external": external,
        "ext-port": ext_port,} }

    params[:"external"].each do |k, v|
        if not v 
            params[:"external"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating external') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/external"
    ext_program = new_resource.ext_program
    ext_preference = new_resource.ext_preference
    ext_arguments = new_resource.ext_arguments
    uuid = new_resource.uuid
    external = new_resource.external
    ext_port = new_resource.ext_port

    params = { "external": {"ext-program": ext_program,
        "ext-preference": ext_preference,
        "ext-arguments": ext_arguments,
        "uuid": uuid,
        "external": external,
        "ext-port": ext_port,} }

    params[:"external"].each do |k, v|
        if not v
            params[:"external"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["external"].each do |k, v|
        if v != params[:"external"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating external') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/external"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting external') do
            client.delete(url)
        end
    end
end