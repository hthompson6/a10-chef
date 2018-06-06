resource_name :a10_cgnv6_nat64_fragmentation_df_bit_transparency

property :a10_name, String, name_property: true
property :df_bit_value, ['enable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat64/fragmentation/"
    get_url = "/axapi/v3/cgnv6/nat64/fragmentation/df-bit-transparency"
    df_bit_value = new_resource.df_bit_value
    uuid = new_resource.uuid

    params = { "df-bit-transparency": {"df-bit-value": df_bit_value,
        "uuid": uuid,} }

    params[:"df-bit-transparency"].each do |k, v|
        if not v 
            params[:"df-bit-transparency"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating df-bit-transparency') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/fragmentation/df-bit-transparency"
    df_bit_value = new_resource.df_bit_value
    uuid = new_resource.uuid

    params = { "df-bit-transparency": {"df-bit-value": df_bit_value,
        "uuid": uuid,} }

    params[:"df-bit-transparency"].each do |k, v|
        if not v
            params[:"df-bit-transparency"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["df-bit-transparency"].each do |k, v|
        if v != params[:"df-bit-transparency"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating df-bit-transparency') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/fragmentation/df-bit-transparency"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting df-bit-transparency') do
            client.delete(url)
        end
    end
end