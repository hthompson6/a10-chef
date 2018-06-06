resource_name :a10_interface_management_lldp

property :a10_name, String, name_property: true
property :tx_dot1_cfg, Hash
property :notification_cfg, Hash
property :enable_cfg, Hash
property :tx_tlvs_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/management/"
    get_url = "/axapi/v3/interface/management/lldp"
    tx_dot1_cfg = new_resource.tx_dot1_cfg
    notification_cfg = new_resource.notification_cfg
    enable_cfg = new_resource.enable_cfg
    tx_tlvs_cfg = new_resource.tx_tlvs_cfg
    uuid = new_resource.uuid

    params = { "lldp": {"tx-dot1-cfg": tx_dot1_cfg,
        "notification-cfg": notification_cfg,
        "enable-cfg": enable_cfg,
        "tx-tlvs-cfg": tx_tlvs_cfg,
        "uuid": uuid,} }

    params[:"lldp"].each do |k, v|
        if not v 
            params[:"lldp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lldp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/management/lldp"
    tx_dot1_cfg = new_resource.tx_dot1_cfg
    notification_cfg = new_resource.notification_cfg
    enable_cfg = new_resource.enable_cfg
    tx_tlvs_cfg = new_resource.tx_tlvs_cfg
    uuid = new_resource.uuid

    params = { "lldp": {"tx-dot1-cfg": tx_dot1_cfg,
        "notification-cfg": notification_cfg,
        "enable-cfg": enable_cfg,
        "tx-tlvs-cfg": tx_tlvs_cfg,
        "uuid": uuid,} }

    params[:"lldp"].each do |k, v|
        if not v
            params[:"lldp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lldp"].each do |k, v|
        if v != params[:"lldp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lldp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/management/lldp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lldp') do
            client.delete(url)
        end
    end
end