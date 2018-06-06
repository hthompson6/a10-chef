resource_name :a10_system_resource_usage

property :a10_name, String, name_property: true
property :nat_pool_addr_count, Integer
property :class_list_ipv6_addr_count, Integer
property :max_aflex_file_size, Integer
property :class_list_ac_entry_count, Integer
property :aflex_table_entry_count, Integer
property :l4_session_count, Integer
property :ssl_context_memory, Integer
property :auth_portal_html_file_size, Integer
property :auth_portal_image_file_size, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/resource-usage"
    nat_pool_addr_count = new_resource.nat_pool_addr_count
    class_list_ipv6_addr_count = new_resource.class_list_ipv6_addr_count
    max_aflex_file_size = new_resource.max_aflex_file_size
    class_list_ac_entry_count = new_resource.class_list_ac_entry_count
    aflex_table_entry_count = new_resource.aflex_table_entry_count
    l4_session_count = new_resource.l4_session_count
    ssl_context_memory = new_resource.ssl_context_memory
    auth_portal_html_file_size = new_resource.auth_portal_html_file_size
    auth_portal_image_file_size = new_resource.auth_portal_image_file_size
    uuid = new_resource.uuid

    params = { "resource-usage": {"nat-pool-addr-count": nat_pool_addr_count,
        "class-list-ipv6-addr-count": class_list_ipv6_addr_count,
        "max-aflex-file-size": max_aflex_file_size,
        "class-list-ac-entry-count": class_list_ac_entry_count,
        "aflex-table-entry-count": aflex_table_entry_count,
        "l4-session-count": l4_session_count,
        "ssl-context-memory": ssl_context_memory,
        "auth-portal-html-file-size": auth_portal_html_file_size,
        "auth-portal-image-file-size": auth_portal_image_file_size,
        "uuid": uuid,} }

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
    url = "/axapi/v3/system/resource-usage"
    nat_pool_addr_count = new_resource.nat_pool_addr_count
    class_list_ipv6_addr_count = new_resource.class_list_ipv6_addr_count
    max_aflex_file_size = new_resource.max_aflex_file_size
    class_list_ac_entry_count = new_resource.class_list_ac_entry_count
    aflex_table_entry_count = new_resource.aflex_table_entry_count
    l4_session_count = new_resource.l4_session_count
    ssl_context_memory = new_resource.ssl_context_memory
    auth_portal_html_file_size = new_resource.auth_portal_html_file_size
    auth_portal_image_file_size = new_resource.auth_portal_image_file_size
    uuid = new_resource.uuid

    params = { "resource-usage": {"nat-pool-addr-count": nat_pool_addr_count,
        "class-list-ipv6-addr-count": class_list_ipv6_addr_count,
        "max-aflex-file-size": max_aflex_file_size,
        "class-list-ac-entry-count": class_list_ac_entry_count,
        "aflex-table-entry-count": aflex_table_entry_count,
        "l4-session-count": l4_session_count,
        "ssl-context-memory": ssl_context_memory,
        "auth-portal-html-file-size": auth_portal_html_file_size,
        "auth-portal-image-file-size": auth_portal_image_file_size,
        "uuid": uuid,} }

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
    url = "/axapi/v3/system/resource-usage"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting resource-usage') do
            client.delete(url)
        end
    end
end