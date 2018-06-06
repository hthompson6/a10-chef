resource_name :a10_hsm_template

property :a10_name, String, name_property: true
property :health_check_interval, Integer
property :protection_ocs, [true, false]
property :protection_module, [true, false]
property :enroll_timeout, Integer
property :uuid, String
property :encrypted, String
property :worker, Integer
property :user_tag, String
property :template_name, String,required: true
property :password_string, String
property :protection_softcard_hash, String
property :softhsm_enum, ['softHSM','thalesHSM']
property :protection, [true, false]
property :rfs_port, Integer
property :rfs_ip, String
property :hsm_dev, Array
property :softcard, [true, false]
property :password, [true, false]
property :sec_world, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/hsm/template/"
    get_url = "/axapi/v3/hsm/template/%<template-name>s"
    health_check_interval = new_resource.health_check_interval
    protection_ocs = new_resource.protection_ocs
    protection_module = new_resource.protection_module
    enroll_timeout = new_resource.enroll_timeout
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    worker = new_resource.worker
    user_tag = new_resource.user_tag
    template_name = new_resource.template_name
    password_string = new_resource.password_string
    protection_softcard_hash = new_resource.protection_softcard_hash
    softhsm_enum = new_resource.softhsm_enum
    protection = new_resource.protection
    rfs_port = new_resource.rfs_port
    rfs_ip = new_resource.rfs_ip
    hsm_dev = new_resource.hsm_dev
    softcard = new_resource.softcard
    password = new_resource.password
    sec_world = new_resource.sec_world

    params = { "template": {"health-check-interval": health_check_interval,
        "protection-ocs": protection_ocs,
        "protection-module": protection_module,
        "enroll-timeout": enroll_timeout,
        "uuid": uuid,
        "encrypted": encrypted,
        "worker": worker,
        "user-tag": user_tag,
        "template-name": template_name,
        "password-string": password_string,
        "protection-softcard-hash": protection_softcard_hash,
        "softhsm-enum": softhsm_enum,
        "protection": protection,
        "rfs-port": rfs_port,
        "rfs-ip": rfs_ip,
        "hsm-dev": hsm_dev,
        "softcard": softcard,
        "password": password,
        "sec-world": sec_world,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hsm/template/%<template-name>s"
    health_check_interval = new_resource.health_check_interval
    protection_ocs = new_resource.protection_ocs
    protection_module = new_resource.protection_module
    enroll_timeout = new_resource.enroll_timeout
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    worker = new_resource.worker
    user_tag = new_resource.user_tag
    template_name = new_resource.template_name
    password_string = new_resource.password_string
    protection_softcard_hash = new_resource.protection_softcard_hash
    softhsm_enum = new_resource.softhsm_enum
    protection = new_resource.protection
    rfs_port = new_resource.rfs_port
    rfs_ip = new_resource.rfs_ip
    hsm_dev = new_resource.hsm_dev
    softcard = new_resource.softcard
    password = new_resource.password
    sec_world = new_resource.sec_world

    params = { "template": {"health-check-interval": health_check_interval,
        "protection-ocs": protection_ocs,
        "protection-module": protection_module,
        "enroll-timeout": enroll_timeout,
        "uuid": uuid,
        "encrypted": encrypted,
        "worker": worker,
        "user-tag": user_tag,
        "template-name": template_name,
        "password-string": password_string,
        "protection-softcard-hash": protection_softcard_hash,
        "softhsm-enum": softhsm_enum,
        "protection": protection,
        "rfs-port": rfs_port,
        "rfs-ip": rfs_ip,
        "hsm-dev": hsm_dev,
        "softcard": softcard,
        "password": password,
        "sec-world": sec_world,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hsm/template/%<template-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end