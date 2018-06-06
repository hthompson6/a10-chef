resource_name :a10_system_mgmt_port

property :a10_name, String, name_property: true
property :port_index, Integer
property :pci_address, String
property :mac_address, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/mgmt-port"
    port_index = new_resource.port_index
    pci_address = new_resource.pci_address
    mac_address = new_resource.mac_address

    params = { "mgmt-port": {"port-index": port_index,
        "pci-address": pci_address,
        "mac-address": mac_address,} }

    params[:"mgmt-port"].each do |k, v|
        if not v 
            params[:"mgmt-port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mgmt-port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/mgmt-port"
    port_index = new_resource.port_index
    pci_address = new_resource.pci_address
    mac_address = new_resource.mac_address

    params = { "mgmt-port": {"port-index": port_index,
        "pci-address": pci_address,
        "mac-address": mac_address,} }

    params[:"mgmt-port"].each do |k, v|
        if not v
            params[:"mgmt-port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mgmt-port"].each do |k, v|
        if v != params[:"mgmt-port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mgmt-port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/mgmt-port"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mgmt-port') do
            client.delete(url)
        end
    end
end