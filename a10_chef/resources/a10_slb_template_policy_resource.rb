resource_name :a10_slb_template_policy

property :a10_name, String, name_property: true
property :forward_policy, Hash
property :use_destination_ip, [true, false]
property :over_limit, [true, false]
property :class_list, Hash
property :interval, Integer
property :share, [true, false]
property :full_domain_tree, [true, false]
property :over_limit_logging, [true, false]
property :bw_list_name, String
property :timeout, Integer
property :sampling_enable, Array
property :user_tag, String
property :bw_list_id, Array
property :over_limit_lockup, Integer
property :uuid, String
property :over_limit_reset, [true, false]
property :overlap, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s"
    forward_policy = new_resource.forward_policy
    use_destination_ip = new_resource.use_destination_ip
    a10_name = new_resource.a10_name
    over_limit = new_resource.over_limit
    class_list = new_resource.class_list
    interval = new_resource.interval
    share = new_resource.share
    full_domain_tree = new_resource.full_domain_tree
    over_limit_logging = new_resource.over_limit_logging
    bw_list_name = new_resource.bw_list_name
    timeout = new_resource.timeout
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    bw_list_id = new_resource.bw_list_id
    over_limit_lockup = new_resource.over_limit_lockup
    uuid = new_resource.uuid
    over_limit_reset = new_resource.over_limit_reset
    overlap = new_resource.overlap

    params = { "policy": {"forward-policy": forward_policy,
        "use-destination-ip": use_destination_ip,
        "name": a10_name,
        "over-limit": over_limit,
        "class-list": class_list,
        "interval": interval,
        "share": share,
        "full-domain-tree": full_domain_tree,
        "over-limit-logging": over_limit_logging,
        "bw-list-name": bw_list_name,
        "timeout": timeout,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "bw-list-id": bw_list_id,
        "over-limit-lockup": over_limit_lockup,
        "uuid": uuid,
        "over-limit-reset": over_limit_reset,
        "overlap": overlap,} }

    params[:"policy"].each do |k, v|
        if not v 
            params[:"policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s"
    forward_policy = new_resource.forward_policy
    use_destination_ip = new_resource.use_destination_ip
    a10_name = new_resource.a10_name
    over_limit = new_resource.over_limit
    class_list = new_resource.class_list
    interval = new_resource.interval
    share = new_resource.share
    full_domain_tree = new_resource.full_domain_tree
    over_limit_logging = new_resource.over_limit_logging
    bw_list_name = new_resource.bw_list_name
    timeout = new_resource.timeout
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    bw_list_id = new_resource.bw_list_id
    over_limit_lockup = new_resource.over_limit_lockup
    uuid = new_resource.uuid
    over_limit_reset = new_resource.over_limit_reset
    overlap = new_resource.overlap

    params = { "policy": {"forward-policy": forward_policy,
        "use-destination-ip": use_destination_ip,
        "name": a10_name,
        "over-limit": over_limit,
        "class-list": class_list,
        "interval": interval,
        "share": share,
        "full-domain-tree": full_domain_tree,
        "over-limit-logging": over_limit_logging,
        "bw-list-name": bw_list_name,
        "timeout": timeout,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "bw-list-id": bw_list_id,
        "over-limit-lockup": over_limit_lockup,
        "uuid": uuid,
        "over-limit-reset": over_limit_reset,
        "overlap": overlap,} }

    params[:"policy"].each do |k, v|
        if not v
            params[:"policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["policy"].each do |k, v|
        if v != params[:"policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting policy') do
            client.delete(url)
        end
    end
end