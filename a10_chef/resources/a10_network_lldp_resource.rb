resource_name :a10_network_lldp

property :a10_name, String, name_property: true
property :uuid, String
property :system_description, String
property :management_address, Hash
property :notification_cfg, Hash
property :tx_set, Hash
property :enable_cfg, Hash
property :system_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/lldp"
    uuid = new_resource.uuid
    system_description = new_resource.system_description
    management_address = new_resource.management_address
    notification_cfg = new_resource.notification_cfg
    tx_set = new_resource.tx_set
    enable_cfg = new_resource.enable_cfg
    system_name = new_resource.system_name

    params = { "lldp": {"uuid": uuid,
        "system-description": system_description,
        "management-address": management_address,
        "notification-cfg": notification_cfg,
        "tx-set": tx_set,
        "enable-cfg": enable_cfg,
        "system-name": system_name,} }

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
    url = "/axapi/v3/network/lldp"
    uuid = new_resource.uuid
    system_description = new_resource.system_description
    management_address = new_resource.management_address
    notification_cfg = new_resource.notification_cfg
    tx_set = new_resource.tx_set
    enable_cfg = new_resource.enable_cfg
    system_name = new_resource.system_name

    params = { "lldp": {"uuid": uuid,
        "system-description": system_description,
        "management-address": management_address,
        "notification-cfg": notification_cfg,
        "tx-set": tx_set,
        "enable-cfg": enable_cfg,
        "system-name": system_name,} }

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
    url = "/axapi/v3/network/lldp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lldp') do
            client.delete(url)
        end
    end
end