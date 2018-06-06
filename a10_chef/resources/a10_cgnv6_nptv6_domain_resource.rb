resource_name :a10_cgnv6_nptv6_domain

property :a10_name, String, name_property: true
property :outside_prefix, String
property :inside_prefix, String
property :user_tag, String
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nptv6/domain/"
    get_url = "/axapi/v3/cgnv6/nptv6/domain/%<name>s"
    outside_prefix = new_resource.outside_prefix
    a10_name = new_resource.a10_name
    inside_prefix = new_resource.inside_prefix
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "domain": {"outside-prefix": outside_prefix,
        "name": a10_name,
        "inside-prefix": inside_prefix,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v 
            params[:"domain"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nptv6/domain/%<name>s"
    outside_prefix = new_resource.outside_prefix
    a10_name = new_resource.a10_name
    inside_prefix = new_resource.inside_prefix
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "domain": {"outside-prefix": outside_prefix,
        "name": a10_name,
        "inside-prefix": inside_prefix,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"domain"].each do |k, v|
        if not v
            params[:"domain"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain"].each do |k, v|
        if v != params[:"domain"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nptv6/domain/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain') do
            client.delete(url)
        end
    end
end