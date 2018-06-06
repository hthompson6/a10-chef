resource_name :a10_license_manager

property :a10_name, String, name_property: true
property :reminder_list, Array
property :bandwidth_base, Integer
property :use_mgmt_port, [true, false]
property :interval, Integer
property :uuid, String
property :overage, Hash
property :connect, Hash
property :host_list, Array
property :bandwidth_unrestricted, [true, false]
property :instance_name, String
property :sn, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/license-manager"
    reminder_list = new_resource.reminder_list
    bandwidth_base = new_resource.bandwidth_base
    use_mgmt_port = new_resource.use_mgmt_port
    interval = new_resource.interval
    uuid = new_resource.uuid
    overage = new_resource.overage
    connect = new_resource.connect
    host_list = new_resource.host_list
    bandwidth_unrestricted = new_resource.bandwidth_unrestricted
    instance_name = new_resource.instance_name
    sn = new_resource.sn

    params = { "license-manager": {"reminder-list": reminder_list,
        "bandwidth-base": bandwidth_base,
        "use-mgmt-port": use_mgmt_port,
        "interval": interval,
        "uuid": uuid,
        "overage": overage,
        "connect": connect,
        "host-list": host_list,
        "bandwidth-unrestricted": bandwidth_unrestricted,
        "instance-name": instance_name,
        "sn": sn,} }

    params[:"license-manager"].each do |k, v|
        if not v 
            params[:"license-manager"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating license-manager') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager"
    reminder_list = new_resource.reminder_list
    bandwidth_base = new_resource.bandwidth_base
    use_mgmt_port = new_resource.use_mgmt_port
    interval = new_resource.interval
    uuid = new_resource.uuid
    overage = new_resource.overage
    connect = new_resource.connect
    host_list = new_resource.host_list
    bandwidth_unrestricted = new_resource.bandwidth_unrestricted
    instance_name = new_resource.instance_name
    sn = new_resource.sn

    params = { "license-manager": {"reminder-list": reminder_list,
        "bandwidth-base": bandwidth_base,
        "use-mgmt-port": use_mgmt_port,
        "interval": interval,
        "uuid": uuid,
        "overage": overage,
        "connect": connect,
        "host-list": host_list,
        "bandwidth-unrestricted": bandwidth_unrestricted,
        "instance-name": instance_name,
        "sn": sn,} }

    params[:"license-manager"].each do |k, v|
        if not v
            params[:"license-manager"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["license-manager"].each do |k, v|
        if v != params[:"license-manager"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating license-manager') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting license-manager') do
            client.delete(url)
        end
    end
end