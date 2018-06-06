resource_name :a10_cgnv6_logging

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :nat_quota_exceeded, Hash
property :nat_resource_exhausted, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/logging"
    sampling_enable = new_resource.sampling_enable
    nat_quota_exceeded = new_resource.nat_quota_exceeded
    nat_resource_exhausted = new_resource.nat_resource_exhausted
    uuid = new_resource.uuid

    params = { "logging": {"sampling-enable": sampling_enable,
        "nat-quota-exceeded": nat_quota_exceeded,
        "nat-resource-exhausted": nat_resource_exhausted,
        "uuid": uuid,} }

    params[:"logging"].each do |k, v|
        if not v 
            params[:"logging"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating logging') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/logging"
    sampling_enable = new_resource.sampling_enable
    nat_quota_exceeded = new_resource.nat_quota_exceeded
    nat_resource_exhausted = new_resource.nat_resource_exhausted
    uuid = new_resource.uuid

    params = { "logging": {"sampling-enable": sampling_enable,
        "nat-quota-exceeded": nat_quota_exceeded,
        "nat-resource-exhausted": nat_resource_exhausted,
        "uuid": uuid,} }

    params[:"logging"].each do |k, v|
        if not v
            params[:"logging"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["logging"].each do |k, v|
        if v != params[:"logging"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating logging') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/logging"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logging') do
            client.delete(url)
        end
    end
end