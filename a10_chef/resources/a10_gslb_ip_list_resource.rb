resource_name :a10_gslb_ip_list

property :a10_name, String, name_property: true
property :gslb_ip_list_obj_name, String,required: true
property :gslb_ip_list_filename, String
property :gslb_ip_list_addr_list, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/ip-list/"
    get_url = "/axapi/v3/gslb/ip-list/%<gslb-ip-list-obj-name>s"
    gslb_ip_list_obj_name = new_resource.gslb_ip_list_obj_name
    gslb_ip_list_filename = new_resource.gslb_ip_list_filename
    gslb_ip_list_addr_list = new_resource.gslb_ip_list_addr_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "ip-list": {"gslb-ip-list-obj-name": gslb_ip_list_obj_name,
        "gslb-ip-list-filename": gslb_ip_list_filename,
        "gslb-ip-list-addr-list": gslb_ip_list_addr_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"ip-list"].each do |k, v|
        if not v 
            params[:"ip-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/ip-list/%<gslb-ip-list-obj-name>s"
    gslb_ip_list_obj_name = new_resource.gslb_ip_list_obj_name
    gslb_ip_list_filename = new_resource.gslb_ip_list_filename
    gslb_ip_list_addr_list = new_resource.gslb_ip_list_addr_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "ip-list": {"gslb-ip-list-obj-name": gslb_ip_list_obj_name,
        "gslb-ip-list-filename": gslb_ip_list_filename,
        "gslb-ip-list-addr-list": gslb_ip_list_addr_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"ip-list"].each do |k, v|
        if not v
            params[:"ip-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip-list"].each do |k, v|
        if v != params[:"ip-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/ip-list/%<gslb-ip-list-obj-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip-list') do
            client.delete(url)
        end
    end
end