resource_name :a10_sys_ut_template_tcp_options

property :a10_name, String, name_property: true
property :uuid, String
property :mss, Integer
property :sack_type, ['permitted','block']
property :time_stamp_enable, [true, false]
property :nop, [true, false]
property :wscale, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/%<name>s/tcp/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s/tcp/options"
    uuid = new_resource.uuid
    mss = new_resource.mss
    sack_type = new_resource.sack_type
    time_stamp_enable = new_resource.time_stamp_enable
    nop = new_resource.nop
    wscale = new_resource.wscale

    params = { "options": {"uuid": uuid,
        "mss": mss,
        "sack-type": sack_type,
        "time-stamp-enable": time_stamp_enable,
        "nop": nop,
        "wscale": wscale,} }

    params[:"options"].each do |k, v|
        if not v 
            params[:"options"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating options') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/tcp/options"
    uuid = new_resource.uuid
    mss = new_resource.mss
    sack_type = new_resource.sack_type
    time_stamp_enable = new_resource.time_stamp_enable
    nop = new_resource.nop
    wscale = new_resource.wscale

    params = { "options": {"uuid": uuid,
        "mss": mss,
        "sack-type": sack_type,
        "time-stamp-enable": time_stamp_enable,
        "nop": nop,
        "wscale": wscale,} }

    params[:"options"].each do |k, v|
        if not v
            params[:"options"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["options"].each do |k, v|
        if v != params[:"options"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating options') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/tcp/options"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting options') do
            client.delete(url)
        end
    end
end