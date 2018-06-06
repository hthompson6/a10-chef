resource_name :a10_overlay_tunnel_options

property :a10_name, String, name_property: true
property :nvgre_key_mode_lower24, [true, false]
property :uuid, String
property :tcp_mss_adjust_disable, [true, false]
property :gateway_mac, String
property :ip_dscp_preserve, [true, false]
property :nvgre_disable_flow_id, [true, false]
property :vxlan_dest_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-tunnel/"
    get_url = "/axapi/v3/overlay-tunnel/options"
    nvgre_key_mode_lower24 = new_resource.nvgre_key_mode_lower24
    uuid = new_resource.uuid
    tcp_mss_adjust_disable = new_resource.tcp_mss_adjust_disable
    gateway_mac = new_resource.gateway_mac
    ip_dscp_preserve = new_resource.ip_dscp_preserve
    nvgre_disable_flow_id = new_resource.nvgre_disable_flow_id
    vxlan_dest_port = new_resource.vxlan_dest_port

    params = { "options": {"nvgre-key-mode-lower24": nvgre_key_mode_lower24,
        "uuid": uuid,
        "tcp-mss-adjust-disable": tcp_mss_adjust_disable,
        "gateway-mac": gateway_mac,
        "ip-dscp-preserve": ip_dscp_preserve,
        "nvgre-disable-flow-id": nvgre_disable_flow_id,
        "vxlan-dest-port": vxlan_dest_port,} }

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
    url = "/axapi/v3/overlay-tunnel/options"
    nvgre_key_mode_lower24 = new_resource.nvgre_key_mode_lower24
    uuid = new_resource.uuid
    tcp_mss_adjust_disable = new_resource.tcp_mss_adjust_disable
    gateway_mac = new_resource.gateway_mac
    ip_dscp_preserve = new_resource.ip_dscp_preserve
    nvgre_disable_flow_id = new_resource.nvgre_disable_flow_id
    vxlan_dest_port = new_resource.vxlan_dest_port

    params = { "options": {"nvgre-key-mode-lower24": nvgre_key_mode_lower24,
        "uuid": uuid,
        "tcp-mss-adjust-disable": tcp_mss_adjust_disable,
        "gateway-mac": gateway_mac,
        "ip-dscp-preserve": ip_dscp_preserve,
        "nvgre-disable-flow-id": nvgre_disable_flow_id,
        "vxlan-dest-port": vxlan_dest_port,} }

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
    url = "/axapi/v3/overlay-tunnel/options"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting options') do
            client.delete(url)
        end
    end
end