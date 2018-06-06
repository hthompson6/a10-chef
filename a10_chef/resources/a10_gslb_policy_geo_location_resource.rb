resource_name :a10_gslb_policy_geo_location

property :a10_name, String, name_property: true
property :ip_multiple_fields, Array
property :uuid, String
property :user_tag, String
property :ipv6_multiple_fields, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/geo-location/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/geo-location/%<name>s"
    ip_multiple_fields = new_resource.ip_multiple_fields
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    ipv6_multiple_fields = new_resource.ipv6_multiple_fields

    params = { "geo-location": {"ip-multiple-fields": ip_multiple_fields,
        "uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "ipv6-multiple-fields": ipv6_multiple_fields,} }

    params[:"geo-location"].each do |k, v|
        if not v 
            params[:"geo-location"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating geo-location') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/geo-location/%<name>s"
    ip_multiple_fields = new_resource.ip_multiple_fields
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    ipv6_multiple_fields = new_resource.ipv6_multiple_fields

    params = { "geo-location": {"ip-multiple-fields": ip_multiple_fields,
        "uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "ipv6-multiple-fields": ipv6_multiple_fields,} }

    params[:"geo-location"].each do |k, v|
        if not v
            params[:"geo-location"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["geo-location"].each do |k, v|
        if v != params[:"geo-location"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating geo-location') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/geo-location/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting geo-location') do
            client.delete(url)
        end
    end
end