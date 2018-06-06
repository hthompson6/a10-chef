resource_name :a10_cgnv6_resource_usage

property :a10_name, String, name_property: true
property :uuid, String
property :fixed_nat_inside_user_count, Integer
property :lsn_nat_addr_count, Integer
property :fixed_nat_ip_addr_count, Integer
property :stateless_entries, Hash
property :radius_table_size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/resource-usage"
    uuid = new_resource.uuid
    fixed_nat_inside_user_count = new_resource.fixed_nat_inside_user_count
    lsn_nat_addr_count = new_resource.lsn_nat_addr_count
    fixed_nat_ip_addr_count = new_resource.fixed_nat_ip_addr_count
    stateless_entries = new_resource.stateless_entries
    radius_table_size = new_resource.radius_table_size

    params = { "resource-usage": {"uuid": uuid,
        "fixed-nat-inside-user-count": fixed_nat_inside_user_count,
        "lsn-nat-addr-count": lsn_nat_addr_count,
        "fixed-nat-ip-addr-count": fixed_nat_ip_addr_count,
        "stateless-entries": stateless_entries,
        "radius-table-size": radius_table_size,} }

    params[:"resource-usage"].each do |k, v|
        if not v 
            params[:"resource-usage"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating resource-usage') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/resource-usage"
    uuid = new_resource.uuid
    fixed_nat_inside_user_count = new_resource.fixed_nat_inside_user_count
    lsn_nat_addr_count = new_resource.lsn_nat_addr_count
    fixed_nat_ip_addr_count = new_resource.fixed_nat_ip_addr_count
    stateless_entries = new_resource.stateless_entries
    radius_table_size = new_resource.radius_table_size

    params = { "resource-usage": {"uuid": uuid,
        "fixed-nat-inside-user-count": fixed_nat_inside_user_count,
        "lsn-nat-addr-count": lsn_nat_addr_count,
        "fixed-nat-ip-addr-count": fixed_nat_ip_addr_count,
        "stateless-entries": stateless_entries,
        "radius-table-size": radius_table_size,} }

    params[:"resource-usage"].each do |k, v|
        if not v
            params[:"resource-usage"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["resource-usage"].each do |k, v|
        if v != params[:"resource-usage"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating resource-usage') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/resource-usage"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting resource-usage') do
            client.delete(url)
        end
    end
end