resource_name :a10_copy

property :a10_name, String, name_property: true
property :profile, String
property :dest_profile, String
property :dest_remote_file, String
property :use_mgmt_port, [true, false]
property :dest_use_mgmt_port, [true, false]
property :remote_file, String
property :startup_config, [true, false]
property :to_profile, String
property :to_startup_config, [true, false]
property :running_config, [true, false]
property :to_running_config, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/copy"
    profile = new_resource.profile
    dest_profile = new_resource.dest_profile
    dest_remote_file = new_resource.dest_remote_file
    use_mgmt_port = new_resource.use_mgmt_port
    dest_use_mgmt_port = new_resource.dest_use_mgmt_port
    remote_file = new_resource.remote_file
    startup_config = new_resource.startup_config
    to_profile = new_resource.to_profile
    to_startup_config = new_resource.to_startup_config
    running_config = new_resource.running_config
    to_running_config = new_resource.to_running_config

    params = { "copy": {"profile": profile,
        "dest-profile": dest_profile,
        "dest-remote-file": dest_remote_file,
        "use-mgmt-port": use_mgmt_port,
        "dest-use-mgmt-port": dest_use_mgmt_port,
        "remote-file": remote_file,
        "startup-config": startup_config,
        "to-profile": to_profile,
        "to-startup-config": to_startup_config,
        "running-config": running_config,
        "to-running-config": to_running_config,} }

    params[:"copy"].each do |k, v|
        if not v 
            params[:"copy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating copy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/copy"
    profile = new_resource.profile
    dest_profile = new_resource.dest_profile
    dest_remote_file = new_resource.dest_remote_file
    use_mgmt_port = new_resource.use_mgmt_port
    dest_use_mgmt_port = new_resource.dest_use_mgmt_port
    remote_file = new_resource.remote_file
    startup_config = new_resource.startup_config
    to_profile = new_resource.to_profile
    to_startup_config = new_resource.to_startup_config
    running_config = new_resource.running_config
    to_running_config = new_resource.to_running_config

    params = { "copy": {"profile": profile,
        "dest-profile": dest_profile,
        "dest-remote-file": dest_remote_file,
        "use-mgmt-port": use_mgmt_port,
        "dest-use-mgmt-port": dest_use_mgmt_port,
        "remote-file": remote_file,
        "startup-config": startup_config,
        "to-profile": to_profile,
        "to-startup-config": to_startup_config,
        "running-config": running_config,
        "to-running-config": to_running_config,} }

    params[:"copy"].each do |k, v|
        if not v
            params[:"copy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["copy"].each do |k, v|
        if v != params[:"copy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating copy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/copy"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting copy') do
            client.delete(url)
        end
    end
end