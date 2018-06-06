resource_name :a10_gslb_template_csv

property :a10_name, String, name_property: true
property :uuid, String
property :csv_name, String,required: true
property :user_tag, String
property :ipv6_enable, [true, false]
property :delim_num, Integer
property :delim_char, String
property :multiple_fields, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/template/csv/"
    get_url = "/axapi/v3/gslb/template/csv/%<csv-name>s"
    uuid = new_resource.uuid
    csv_name = new_resource.csv_name
    user_tag = new_resource.user_tag
    ipv6_enable = new_resource.ipv6_enable
    delim_num = new_resource.delim_num
    delim_char = new_resource.delim_char
    multiple_fields = new_resource.multiple_fields

    params = { "csv": {"uuid": uuid,
        "csv-name": csv_name,
        "user-tag": user_tag,
        "ipv6-enable": ipv6_enable,
        "delim-num": delim_num,
        "delim-char": delim_char,
        "multiple-fields": multiple_fields,} }

    params[:"csv"].each do |k, v|
        if not v 
            params[:"csv"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating csv') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/template/csv/%<csv-name>s"
    uuid = new_resource.uuid
    csv_name = new_resource.csv_name
    user_tag = new_resource.user_tag
    ipv6_enable = new_resource.ipv6_enable
    delim_num = new_resource.delim_num
    delim_char = new_resource.delim_char
    multiple_fields = new_resource.multiple_fields

    params = { "csv": {"uuid": uuid,
        "csv-name": csv_name,
        "user-tag": user_tag,
        "ipv6-enable": ipv6_enable,
        "delim-num": delim_num,
        "delim-char": delim_char,
        "multiple-fields": multiple_fields,} }

    params[:"csv"].each do |k, v|
        if not v
            params[:"csv"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["csv"].each do |k, v|
        if v != params[:"csv"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating csv') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/template/csv/%<csv-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting csv') do
            client.delete(url)
        end
    end
end