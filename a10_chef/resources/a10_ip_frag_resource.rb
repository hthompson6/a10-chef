resource_name :a10_ip_frag

property :a10_name, String, name_property: true
property :uuid, String
property :max_reassembly_sessions, Integer
property :sampling_enable, Array
property :cpu_threshold, Hash
property :timeout, Integer
property :max_packets_per_reassembly, Integer
property :buff, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/frag"
    uuid = new_resource.uuid
    max_reassembly_sessions = new_resource.max_reassembly_sessions
    sampling_enable = new_resource.sampling_enable
    cpu_threshold = new_resource.cpu_threshold
    timeout = new_resource.timeout
    max_packets_per_reassembly = new_resource.max_packets_per_reassembly
    buff = new_resource.buff

    params = { "frag": {"uuid": uuid,
        "max-reassembly-sessions": max_reassembly_sessions,
        "sampling-enable": sampling_enable,
        "cpu-threshold": cpu_threshold,
        "timeout": timeout,
        "max-packets-per-reassembly": max_packets_per_reassembly,
        "buff": buff,} }

    params[:"frag"].each do |k, v|
        if not v 
            params[:"frag"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating frag') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/frag"
    uuid = new_resource.uuid
    max_reassembly_sessions = new_resource.max_reassembly_sessions
    sampling_enable = new_resource.sampling_enable
    cpu_threshold = new_resource.cpu_threshold
    timeout = new_resource.timeout
    max_packets_per_reassembly = new_resource.max_packets_per_reassembly
    buff = new_resource.buff

    params = { "frag": {"uuid": uuid,
        "max-reassembly-sessions": max_reassembly_sessions,
        "sampling-enable": sampling_enable,
        "cpu-threshold": cpu_threshold,
        "timeout": timeout,
        "max-packets-per-reassembly": max_packets_per_reassembly,
        "buff": buff,} }

    params[:"frag"].each do |k, v|
        if not v
            params[:"frag"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["frag"].each do |k, v|
        if v != params[:"frag"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating frag') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/frag"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting frag') do
            client.delete(url)
        end
    end
end