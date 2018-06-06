resource_name :a10_gslb_service_group

property :a10_name, String, name_property: true
property :service_group_name, String,required: true
property :uuid, String
property :dependency_site, [true, false]
property :disable_site_list, Array
property :user_tag, String
property :persistent_mask, String
property :member, Array
property :disable, [true, false]
property :persistent_ipv6_mask, Integer
property :persistent_aging_time, Integer
property :persistent_site, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/service-group/"
    get_url = "/axapi/v3/gslb/service-group/%<service-group-name>s"
    service_group_name = new_resource.service_group_name
    uuid = new_resource.uuid
    dependency_site = new_resource.dependency_site
    disable_site_list = new_resource.disable_site_list
    user_tag = new_resource.user_tag
    persistent_mask = new_resource.persistent_mask
    member = new_resource.member
    disable = new_resource.disable
    persistent_ipv6_mask = new_resource.persistent_ipv6_mask
    persistent_aging_time = new_resource.persistent_aging_time
    persistent_site = new_resource.persistent_site

    params = { "service-group": {"service-group-name": service_group_name,
        "uuid": uuid,
        "dependency-site": dependency_site,
        "disable-site-list": disable_site_list,
        "user-tag": user_tag,
        "persistent-mask": persistent_mask,
        "member": member,
        "disable": disable,
        "persistent-ipv6-mask": persistent_ipv6_mask,
        "persistent-aging-time": persistent_aging_time,
        "persistent-site": persistent_site,} }

    params[:"service-group"].each do |k, v|
        if not v 
            params[:"service-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/service-group/%<service-group-name>s"
    service_group_name = new_resource.service_group_name
    uuid = new_resource.uuid
    dependency_site = new_resource.dependency_site
    disable_site_list = new_resource.disable_site_list
    user_tag = new_resource.user_tag
    persistent_mask = new_resource.persistent_mask
    member = new_resource.member
    disable = new_resource.disable
    persistent_ipv6_mask = new_resource.persistent_ipv6_mask
    persistent_aging_time = new_resource.persistent_aging_time
    persistent_site = new_resource.persistent_site

    params = { "service-group": {"service-group-name": service_group_name,
        "uuid": uuid,
        "dependency-site": dependency_site,
        "disable-site-list": disable_site_list,
        "user-tag": user_tag,
        "persistent-mask": persistent_mask,
        "member": member,
        "disable": disable,
        "persistent-ipv6-mask": persistent_ipv6_mask,
        "persistent-aging-time": persistent_aging_time,
        "persistent-site": persistent_site,} }

    params[:"service-group"].each do |k, v|
        if not v
            params[:"service-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-group"].each do |k, v|
        if v != params[:"service-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/service-group/%<service-group-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-group') do
            client.delete(url)
        end
    end
end