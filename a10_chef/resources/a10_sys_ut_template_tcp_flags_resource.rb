resource_name :a10_sys_ut_template_tcp_flags

property :a10_name, String, name_property: true
property :ece, [true, false]
property :urg, [true, false]
property :uuid, String
property :ack, [true, false]
property :cwr, [true, false]
property :psh, [true, false]
property :syn, [true, false]
property :rst, [true, false]
property :fin, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/%<name>s/tcp/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s/tcp/flags"
    ece = new_resource.ece
    urg = new_resource.urg
    uuid = new_resource.uuid
    ack = new_resource.ack
    cwr = new_resource.cwr
    psh = new_resource.psh
    syn = new_resource.syn
    rst = new_resource.rst
    fin = new_resource.fin

    params = { "flags": {"ece": ece,
        "urg": urg,
        "uuid": uuid,
        "ack": ack,
        "cwr": cwr,
        "psh": psh,
        "syn": syn,
        "rst": rst,
        "fin": fin,} }

    params[:"flags"].each do |k, v|
        if not v 
            params[:"flags"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating flags') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/tcp/flags"
    ece = new_resource.ece
    urg = new_resource.urg
    uuid = new_resource.uuid
    ack = new_resource.ack
    cwr = new_resource.cwr
    psh = new_resource.psh
    syn = new_resource.syn
    rst = new_resource.rst
    fin = new_resource.fin

    params = { "flags": {"ece": ece,
        "urg": urg,
        "uuid": uuid,
        "ack": ack,
        "cwr": cwr,
        "psh": psh,
        "syn": syn,
        "rst": rst,
        "fin": fin,} }

    params[:"flags"].each do |k, v|
        if not v
            params[:"flags"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["flags"].each do |k, v|
        if v != params[:"flags"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating flags') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/tcp/flags"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting flags') do
            client.delete(url)
        end
    end
end