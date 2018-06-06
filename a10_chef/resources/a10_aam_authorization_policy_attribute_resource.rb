resource_name :a10_aam_authorization_policy_attribute

property :a10_name, String, name_property: true
property :attribute_name, String
property :ip_type, [true, false]
property :custom_attr_type, [true, false]
property :uuid, String
property :string_type, [true, false]
property :attr_str_val, String
property :attr_ipv4, String
property :attr_type, [true, false]
property :attr_num, Integer,required: true
property :a10_dynamic_defined, [true, false]
property :attr_int, ['equal','not-equal','less-than','more-than','less-than-equal-to','more-than-equal-to']
property :integer_type, [true, false]
property :attr_ip, ['equal','not-equal']
property :A10_AX_AUTH_URI, [true, false]
property :attr_str, ['match','sub-string']
property :custom_attr_str, ['match','sub-string']
property :attr_int_val, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authorization/policy/%<name>s/attribute/"
    get_url = "/axapi/v3/aam/authorization/policy/%<name>s/attribute/%<attr-num>s"
    attribute_name = new_resource.attribute_name
    ip_type = new_resource.ip_type
    custom_attr_type = new_resource.custom_attr_type
    uuid = new_resource.uuid
    string_type = new_resource.string_type
    attr_str_val = new_resource.attr_str_val
    attr_ipv4 = new_resource.attr_ipv4
    attr_type = new_resource.attr_type
    attr_num = new_resource.attr_num
    a10_dynamic_defined = new_resource.a10_dynamic_defined
    attr_int = new_resource.attr_int
    integer_type = new_resource.integer_type
    attr_ip = new_resource.attr_ip
    A10_AX_AUTH_URI = new_resource.A10_AX_AUTH_URI
    attr_str = new_resource.attr_str
    custom_attr_str = new_resource.custom_attr_str
    attr_int_val = new_resource.attr_int_val

    params = { "attribute": {"attribute-name": attribute_name,
        "ip-type": ip_type,
        "custom-attr-type": custom_attr_type,
        "uuid": uuid,
        "string-type": string_type,
        "attr-str-val": attr_str_val,
        "attr-ipv4": attr_ipv4,
        "attr-type": attr_type,
        "attr-num": attr_num,
        "a10-dynamic-defined": a10_dynamic_defined,
        "attr-int": attr_int,
        "integer-type": integer_type,
        "attr-ip": attr_ip,
        "A10-AX-AUTH-URI": A10_AX_AUTH_URI,
        "attr-str": attr_str,
        "custom-attr-str": custom_attr_str,
        "attr-int-val": attr_int_val,} }

    params[:"attribute"].each do |k, v|
        if not v 
            params[:"attribute"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating attribute') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authorization/policy/%<name>s/attribute/%<attr-num>s"
    attribute_name = new_resource.attribute_name
    ip_type = new_resource.ip_type
    custom_attr_type = new_resource.custom_attr_type
    uuid = new_resource.uuid
    string_type = new_resource.string_type
    attr_str_val = new_resource.attr_str_val
    attr_ipv4 = new_resource.attr_ipv4
    attr_type = new_resource.attr_type
    attr_num = new_resource.attr_num
    a10_dynamic_defined = new_resource.a10_dynamic_defined
    attr_int = new_resource.attr_int
    integer_type = new_resource.integer_type
    attr_ip = new_resource.attr_ip
    A10_AX_AUTH_URI = new_resource.A10_AX_AUTH_URI
    attr_str = new_resource.attr_str
    custom_attr_str = new_resource.custom_attr_str
    attr_int_val = new_resource.attr_int_val

    params = { "attribute": {"attribute-name": attribute_name,
        "ip-type": ip_type,
        "custom-attr-type": custom_attr_type,
        "uuid": uuid,
        "string-type": string_type,
        "attr-str-val": attr_str_val,
        "attr-ipv4": attr_ipv4,
        "attr-type": attr_type,
        "attr-num": attr_num,
        "a10-dynamic-defined": a10_dynamic_defined,
        "attr-int": attr_int,
        "integer-type": integer_type,
        "attr-ip": attr_ip,
        "A10-AX-AUTH-URI": A10_AX_AUTH_URI,
        "attr-str": attr_str,
        "custom-attr-str": custom_attr_str,
        "attr-int-val": attr_int_val,} }

    params[:"attribute"].each do |k, v|
        if not v
            params[:"attribute"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["attribute"].each do |k, v|
        if v != params[:"attribute"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating attribute') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authorization/policy/%<name>s/attribute/%<attr-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting attribute') do
            client.delete(url)
        end
    end
end