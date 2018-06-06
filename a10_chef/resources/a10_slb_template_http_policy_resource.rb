resource_name :a10_slb_template_http_policy

property :a10_name, String, name_property: true
property :cookie_name, String
property :http_policy_match, Array
property :uuid, String
property :user_tag, String
property :geo_location_match, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/http-policy/"
    get_url = "/axapi/v3/slb/template/http-policy/%<name>s"
    cookie_name = new_resource.cookie_name
    a10_name = new_resource.a10_name
    http_policy_match = new_resource.http_policy_match
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    geo_location_match = new_resource.geo_location_match

    params = { "http-policy": {"cookie-name": cookie_name,
        "name": a10_name,
        "http-policy-match": http_policy_match,
        "uuid": uuid,
        "user-tag": user_tag,
        "geo-location-match": geo_location_match,} }

    params[:"http-policy"].each do |k, v|
        if not v 
            params[:"http-policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http-policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/http-policy/%<name>s"
    cookie_name = new_resource.cookie_name
    a10_name = new_resource.a10_name
    http_policy_match = new_resource.http_policy_match
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    geo_location_match = new_resource.geo_location_match

    params = { "http-policy": {"cookie-name": cookie_name,
        "name": a10_name,
        "http-policy-match": http_policy_match,
        "uuid": uuid,
        "user-tag": user_tag,
        "geo-location-match": geo_location_match,} }

    params[:"http-policy"].each do |k, v|
        if not v
            params[:"http-policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http-policy"].each do |k, v|
        if v != params[:"http-policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http-policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/http-policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http-policy') do
            client.delete(url)
        end
    end
end