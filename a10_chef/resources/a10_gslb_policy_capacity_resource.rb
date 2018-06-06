resource_name :a10_gslb_policy_capacity

property :a10_name, String, name_property: true
property :threshold, Integer
property :capacity_enable, [true, false]
property :capacity_fail_break, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/capacity"
    threshold = new_resource.threshold
    capacity_enable = new_resource.capacity_enable
    capacity_fail_break = new_resource.capacity_fail_break
    uuid = new_resource.uuid

    params = { "capacity": {"threshold": threshold,
        "capacity-enable": capacity_enable,
        "capacity-fail-break": capacity_fail_break,
        "uuid": uuid,} }

    params[:"capacity"].each do |k, v|
        if not v 
            params[:"capacity"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating capacity') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/capacity"
    threshold = new_resource.threshold
    capacity_enable = new_resource.capacity_enable
    capacity_fail_break = new_resource.capacity_fail_break
    uuid = new_resource.uuid

    params = { "capacity": {"threshold": threshold,
        "capacity-enable": capacity_enable,
        "capacity-fail-break": capacity_fail_break,
        "uuid": uuid,} }

    params[:"capacity"].each do |k, v|
        if not v
            params[:"capacity"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["capacity"].each do |k, v|
        if v != params[:"capacity"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating capacity') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/capacity"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting capacity') do
            client.delete(url)
        end
    end
end