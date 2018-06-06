resource_name :a10_upgrade_hd

property :a10_name, String, name_property: true
property :reboot_after_upgrade, [true, false]
property :use_mgmt_port, [true, false]
property :image, ['pri','sec']
property :source_ip_address, String
property :Device, Integer
property :local, String
property :staggered_upgrade_mode, [true, false]
property :file_url, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/upgrade/"
    get_url = "/axapi/v3/upgrade/hd"
    reboot_after_upgrade = new_resource.reboot_after_upgrade
    use_mgmt_port = new_resource.use_mgmt_port
    image = new_resource.image
    source_ip_address = new_resource.source_ip_address
    Device = new_resource.Device
    local = new_resource.local
    staggered_upgrade_mode = new_resource.staggered_upgrade_mode
    file_url = new_resource.file_url

    params = { "hd": {"reboot-after-upgrade": reboot_after_upgrade,
        "use-mgmt-port": use_mgmt_port,
        "image": image,
        "source-ip-address": source_ip_address,
        "Device": Device,
        "local": local,
        "staggered-upgrade-mode": staggered_upgrade_mode,
        "file-url": file_url,} }

    params[:"hd"].each do |k, v|
        if not v 
            params[:"hd"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating hd') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/upgrade/hd"
    reboot_after_upgrade = new_resource.reboot_after_upgrade
    use_mgmt_port = new_resource.use_mgmt_port
    image = new_resource.image
    source_ip_address = new_resource.source_ip_address
    Device = new_resource.Device
    local = new_resource.local
    staggered_upgrade_mode = new_resource.staggered_upgrade_mode
    file_url = new_resource.file_url

    params = { "hd": {"reboot-after-upgrade": reboot_after_upgrade,
        "use-mgmt-port": use_mgmt_port,
        "image": image,
        "source-ip-address": source_ip_address,
        "Device": Device,
        "local": local,
        "staggered-upgrade-mode": staggered_upgrade_mode,
        "file-url": file_url,} }

    params[:"hd"].each do |k, v|
        if not v
            params[:"hd"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["hd"].each do |k, v|
        if v != params[:"hd"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating hd') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/upgrade/hd"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting hd') do
            client.delete(url)
        end
    end
end