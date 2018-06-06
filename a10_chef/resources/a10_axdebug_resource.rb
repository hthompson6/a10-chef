resource_name :a10_axdebug

property :a10_name, String, name_property: true
property :count, Integer
property :save_config, String
property :timeout, Integer
property :sess_filter_dis, [true, false]
property :outgoing_list, Hash
property :maxfile, Integer
property :capture, Hash
property :length, Integer
property :exit, [true, false]
property :delete_file_list, Hash
property :filter_config, Hash
property :incoming_list, Hash
property :apply_config, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/axdebug"
    count = new_resource.count
    save_config = new_resource.save_config
    timeout = new_resource.timeout
    sess_filter_dis = new_resource.sess_filter_dis
    outgoing_list = new_resource.outgoing_list
    maxfile = new_resource.maxfile
    capture = new_resource.capture
    length = new_resource.length
    exit = new_resource.exit
    delete_file_list = new_resource.delete_file_list
    filter_config = new_resource.filter_config
    incoming_list = new_resource.incoming_list
    apply_config = new_resource.apply_config

    params = { "axdebug": {"count": count,
        "save-config": save_config,
        "timeout": timeout,
        "sess-filter-dis": sess_filter_dis,
        "outgoing-list": outgoing_list,
        "maxfile": maxfile,
        "capture": capture,
        "length": length,
        "exit": exit,
        "delete-file-list": delete_file_list,
        "filter-config": filter_config,
        "incoming-list": incoming_list,
        "apply-config": apply_config,} }

    params[:"axdebug"].each do |k, v|
        if not v 
            params[:"axdebug"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating axdebug') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug"
    count = new_resource.count
    save_config = new_resource.save_config
    timeout = new_resource.timeout
    sess_filter_dis = new_resource.sess_filter_dis
    outgoing_list = new_resource.outgoing_list
    maxfile = new_resource.maxfile
    capture = new_resource.capture
    length = new_resource.length
    exit = new_resource.exit
    delete_file_list = new_resource.delete_file_list
    filter_config = new_resource.filter_config
    incoming_list = new_resource.incoming_list
    apply_config = new_resource.apply_config

    params = { "axdebug": {"count": count,
        "save-config": save_config,
        "timeout": timeout,
        "sess-filter-dis": sess_filter_dis,
        "outgoing-list": outgoing_list,
        "maxfile": maxfile,
        "capture": capture,
        "length": length,
        "exit": exit,
        "delete-file-list": delete_file_list,
        "filter-config": filter_config,
        "incoming-list": incoming_list,
        "apply-config": apply_config,} }

    params[:"axdebug"].each do |k, v|
        if not v
            params[:"axdebug"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["axdebug"].each do |k, v|
        if v != params[:"axdebug"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating axdebug') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting axdebug') do
            client.delete(url)
        end
    end
end