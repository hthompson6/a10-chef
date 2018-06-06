resource_name :a10_delete_cgnv6

property :a10_name, String, name_property: true
property :lw_filename, String
property :lw_4o6_binding_table_validation_log, [true, false]
property :fixed_nat, [true, false]
property :filename, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/cgnv6"
    lw_filename = new_resource.lw_filename
    lw_4o6_binding_table_validation_log = new_resource.lw_4o6_binding_table_validation_log
    fixed_nat = new_resource.fixed_nat
    filename = new_resource.filename

    params = { "cgnv6": {"lw-filename": lw_filename,
        "lw-4o6-binding-table-validation-log": lw_4o6_binding_table_validation_log,
        "fixed-nat": fixed_nat,
        "filename": filename,} }

    params[:"cgnv6"].each do |k, v|
        if not v 
            params[:"cgnv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cgnv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/cgnv6"
    lw_filename = new_resource.lw_filename
    lw_4o6_binding_table_validation_log = new_resource.lw_4o6_binding_table_validation_log
    fixed_nat = new_resource.fixed_nat
    filename = new_resource.filename

    params = { "cgnv6": {"lw-filename": lw_filename,
        "lw-4o6-binding-table-validation-log": lw_4o6_binding_table_validation_log,
        "fixed-nat": fixed_nat,
        "filename": filename,} }

    params[:"cgnv6"].each do |k, v|
        if not v
            params[:"cgnv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cgnv6"].each do |k, v|
        if v != params[:"cgnv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cgnv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/cgnv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cgnv6') do
            client.delete(url)
        end
    end
end