resource_name :a10_slb_template_dblb_calc_sha1

property :a10_name, String, name_property: true
property :sha1_value, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/dblb/%<name>s/"
    get_url = "/axapi/v3/slb/template/dblb/%<name>s/calc-sha1"
    sha1_value = new_resource.sha1_value

    params = { "calc-sha1": {"sha1-value": sha1_value,} }

    params[:"calc-sha1"].each do |k, v|
        if not v 
            params[:"calc-sha1"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating calc-sha1') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dblb/%<name>s/calc-sha1"
    sha1_value = new_resource.sha1_value

    params = { "calc-sha1": {"sha1-value": sha1_value,} }

    params[:"calc-sha1"].each do |k, v|
        if not v
            params[:"calc-sha1"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["calc-sha1"].each do |k, v|
        if v != params[:"calc-sha1"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating calc-sha1') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dblb/%<name>s/calc-sha1"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting calc-sha1') do
            client.delete(url)
        end
    end
end