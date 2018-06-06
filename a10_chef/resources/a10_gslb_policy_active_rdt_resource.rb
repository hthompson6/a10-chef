resource_name :a10_gslb_policy_active_rdt

property :a10_name, String, name_property: true
property :ignore_id, Integer
property :keep_tracking, [true, false]
property :enable, [true, false]
property :timeout, Integer
property :skip, Integer
property :fail_break, [true, false]
property :controller, [true, false]
property :limit, Integer
property :samples, Integer
property :proto_rdt_enable, [true, false]
property :single_shot, [true, false]
property :difference, Integer
property :tolerance, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/active-rdt"
    ignore_id = new_resource.ignore_id
    keep_tracking = new_resource.keep_tracking
    enable = new_resource.enable
    timeout = new_resource.timeout
    skip = new_resource.skip
    fail_break = new_resource.fail_break
    controller = new_resource.controller
    limit = new_resource.limit
    samples = new_resource.samples
    proto_rdt_enable = new_resource.proto_rdt_enable
    single_shot = new_resource.single_shot
    difference = new_resource.difference
    tolerance = new_resource.tolerance
    uuid = new_resource.uuid

    params = { "active-rdt": {"ignore-id": ignore_id,
        "keep-tracking": keep_tracking,
        "enable": enable,
        "timeout": timeout,
        "skip": skip,
        "fail-break": fail_break,
        "controller": controller,
        "limit": limit,
        "samples": samples,
        "proto-rdt-enable": proto_rdt_enable,
        "single-shot": single_shot,
        "difference": difference,
        "tolerance": tolerance,
        "uuid": uuid,} }

    params[:"active-rdt"].each do |k, v|
        if not v 
            params[:"active-rdt"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating active-rdt') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/active-rdt"
    ignore_id = new_resource.ignore_id
    keep_tracking = new_resource.keep_tracking
    enable = new_resource.enable
    timeout = new_resource.timeout
    skip = new_resource.skip
    fail_break = new_resource.fail_break
    controller = new_resource.controller
    limit = new_resource.limit
    samples = new_resource.samples
    proto_rdt_enable = new_resource.proto_rdt_enable
    single_shot = new_resource.single_shot
    difference = new_resource.difference
    tolerance = new_resource.tolerance
    uuid = new_resource.uuid

    params = { "active-rdt": {"ignore-id": ignore_id,
        "keep-tracking": keep_tracking,
        "enable": enable,
        "timeout": timeout,
        "skip": skip,
        "fail-break": fail_break,
        "controller": controller,
        "limit": limit,
        "samples": samples,
        "proto-rdt-enable": proto_rdt_enable,
        "single-shot": single_shot,
        "difference": difference,
        "tolerance": tolerance,
        "uuid": uuid,} }

    params[:"active-rdt"].each do |k, v|
        if not v
            params[:"active-rdt"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["active-rdt"].each do |k, v|
        if v != params[:"active-rdt"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating active-rdt') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/active-rdt"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting active-rdt') do
            client.delete(url)
        end
    end
end