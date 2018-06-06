resource_name :a10_backup_periodic

property :a10_name, String, name_property: true
property :week, Integer
property :log, [true, false]
property :remote_file, String
property :system, [true, false]
property :hour, Integer
property :store_name, String
property :use_mgmt_port, [true, false]
property :fixed_nat, [true, false]
property :day, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/backup-periodic"
    week = new_resource.week
    log = new_resource.log
    remote_file = new_resource.remote_file
    system = new_resource.system
    hour = new_resource.hour
    store_name = new_resource.store_name
    use_mgmt_port = new_resource.use_mgmt_port
    fixed_nat = new_resource.fixed_nat
    day = new_resource.day
    uuid = new_resource.uuid

    params = { "backup-periodic": {"week": week,
        "log": log,
        "remote-file": remote_file,
        "system": system,
        "hour": hour,
        "store-name": store_name,
        "use-mgmt-port": use_mgmt_port,
        "fixed-nat": fixed_nat,
        "day": day,
        "uuid": uuid,} }

    params[:"backup-periodic"].each do |k, v|
        if not v 
            params[:"backup-periodic"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating backup-periodic') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup-periodic"
    week = new_resource.week
    log = new_resource.log
    remote_file = new_resource.remote_file
    system = new_resource.system
    hour = new_resource.hour
    store_name = new_resource.store_name
    use_mgmt_port = new_resource.use_mgmt_port
    fixed_nat = new_resource.fixed_nat
    day = new_resource.day
    uuid = new_resource.uuid

    params = { "backup-periodic": {"week": week,
        "log": log,
        "remote-file": remote_file,
        "system": system,
        "hour": hour,
        "store-name": store_name,
        "use-mgmt-port": use_mgmt_port,
        "fixed-nat": fixed_nat,
        "day": day,
        "uuid": uuid,} }

    params[:"backup-periodic"].each do |k, v|
        if not v
            params[:"backup-periodic"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["backup-periodic"].each do |k, v|
        if v != params[:"backup-periodic"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating backup-periodic') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/backup-periodic"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting backup-periodic') do
            client.delete(url)
        end
    end
end