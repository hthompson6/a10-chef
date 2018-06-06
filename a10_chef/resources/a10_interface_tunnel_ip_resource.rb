resource_name :a10_interface_tunnel_ip

property :a10_name, String, name_property: true
property :uuid, String
property :generate_membership_query, [true, false]
property :max_resp_time, Integer
property :address, Hash
property :ospf, Hash
property :generate_membership_query_val, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/tunnel/%<ifnum>s/"
    get_url = "/axapi/v3/interface/tunnel/%<ifnum>s/ip"
    uuid = new_resource.uuid
    generate_membership_query = new_resource.generate_membership_query
    max_resp_time = new_resource.max_resp_time
    address = new_resource.address
    ospf = new_resource.ospf
    generate_membership_query_val = new_resource.generate_membership_query_val

    params = { "ip": {"uuid": uuid,
        "generate-membership-query": generate_membership_query,
        "max-resp-time": max_resp_time,
        "address": address,
        "ospf": ospf,
        "generate-membership-query-val": generate_membership_query_val,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s/ip"
    uuid = new_resource.uuid
    generate_membership_query = new_resource.generate_membership_query
    max_resp_time = new_resource.max_resp_time
    address = new_resource.address
    ospf = new_resource.ospf
    generate_membership_query_val = new_resource.generate_membership_query_val

    params = { "ip": {"uuid": uuid,
        "generate-membership-query": generate_membership_query,
        "max-resp-time": max_resp_time,
        "address": address,
        "ospf": ospf,
        "generate-membership-query-val": generate_membership_query_val,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s/ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end