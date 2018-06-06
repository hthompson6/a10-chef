resource_name :a10_ip_anomaly_drop

property :a10_name, String, name_property: true
property :frag, [true, false]
property :out_of_sequence, Integer
property :uuid, String
property :tcp_syn_fin, [true, false]
property :drop_all, [true, false]
property :ping_of_death, [true, false]
property :security_attack, Hash
property :tcp_no_flag, [true, false]
property :packet_deformity, Hash
property :zero_window, Integer
property :sampling_enable, Array
property :ip_option, [true, false]
property :land_attack, [true, false]
property :tcp_syn_frag, [true, false]
property :bad_content, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/anomaly-drop"
    frag = new_resource.frag
    out_of_sequence = new_resource.out_of_sequence
    uuid = new_resource.uuid
    tcp_syn_fin = new_resource.tcp_syn_fin
    drop_all = new_resource.drop_all
    ping_of_death = new_resource.ping_of_death
    security_attack = new_resource.security_attack
    tcp_no_flag = new_resource.tcp_no_flag
    packet_deformity = new_resource.packet_deformity
    zero_window = new_resource.zero_window
    sampling_enable = new_resource.sampling_enable
    ip_option = new_resource.ip_option
    land_attack = new_resource.land_attack
    tcp_syn_frag = new_resource.tcp_syn_frag
    bad_content = new_resource.bad_content

    params = { "anomaly-drop": {"frag": frag,
        "out-of-sequence": out_of_sequence,
        "uuid": uuid,
        "tcp-syn-fin": tcp_syn_fin,
        "drop-all": drop_all,
        "ping-of-death": ping_of_death,
        "security-attack": security_attack,
        "tcp-no-flag": tcp_no_flag,
        "packet-deformity": packet_deformity,
        "zero-window": zero_window,
        "sampling-enable": sampling_enable,
        "ip-option": ip_option,
        "land-attack": land_attack,
        "tcp-syn-frag": tcp_syn_frag,
        "bad-content": bad_content,} }

    params[:"anomaly-drop"].each do |k, v|
        if not v 
            params[:"anomaly-drop"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating anomaly-drop') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/anomaly-drop"
    frag = new_resource.frag
    out_of_sequence = new_resource.out_of_sequence
    uuid = new_resource.uuid
    tcp_syn_fin = new_resource.tcp_syn_fin
    drop_all = new_resource.drop_all
    ping_of_death = new_resource.ping_of_death
    security_attack = new_resource.security_attack
    tcp_no_flag = new_resource.tcp_no_flag
    packet_deformity = new_resource.packet_deformity
    zero_window = new_resource.zero_window
    sampling_enable = new_resource.sampling_enable
    ip_option = new_resource.ip_option
    land_attack = new_resource.land_attack
    tcp_syn_frag = new_resource.tcp_syn_frag
    bad_content = new_resource.bad_content

    params = { "anomaly-drop": {"frag": frag,
        "out-of-sequence": out_of_sequence,
        "uuid": uuid,
        "tcp-syn-fin": tcp_syn_fin,
        "drop-all": drop_all,
        "ping-of-death": ping_of_death,
        "security-attack": security_attack,
        "tcp-no-flag": tcp_no_flag,
        "packet-deformity": packet_deformity,
        "zero-window": zero_window,
        "sampling-enable": sampling_enable,
        "ip-option": ip_option,
        "land-attack": land_attack,
        "tcp-syn-frag": tcp_syn_frag,
        "bad-content": bad_content,} }

    params[:"anomaly-drop"].each do |k, v|
        if not v
            params[:"anomaly-drop"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["anomaly-drop"].each do |k, v|
        if v != params[:"anomaly-drop"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating anomaly-drop') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/anomaly-drop"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting anomaly-drop') do
            client.delete(url)
        end
    end
end