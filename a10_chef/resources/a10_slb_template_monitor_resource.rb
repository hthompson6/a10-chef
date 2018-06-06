resource_name :a10_slb_template_monitor

property :a10_name, String, name_property: true
property :clear_cfg, Array
property :uuid, String
property :link_enable_cfg, Array
property :link_up_cfg, Array
property :link_down_cfg, Array
property :user_tag, String
property :link_disable_cfg, Array
property :monitor_relation, ['monitor-and','monitor-or']
property :id, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/monitor/"
    get_url = "/axapi/v3/slb/template/monitor/%<id>s"
    clear_cfg = new_resource.clear_cfg
    uuid = new_resource.uuid
    link_enable_cfg = new_resource.link_enable_cfg
    link_up_cfg = new_resource.link_up_cfg
    link_down_cfg = new_resource.link_down_cfg
    user_tag = new_resource.user_tag
    link_disable_cfg = new_resource.link_disable_cfg
    monitor_relation = new_resource.monitor_relation
    id = new_resource.id

    params = { "monitor": {"clear-cfg": clear_cfg,
        "uuid": uuid,
        "link-enable-cfg": link_enable_cfg,
        "link-up-cfg": link_up_cfg,
        "link-down-cfg": link_down_cfg,
        "user-tag": user_tag,
        "link-disable-cfg": link_disable_cfg,
        "monitor-relation": monitor_relation,
        "id": id,} }

    params[:"monitor"].each do |k, v|
        if not v 
            params[:"monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/monitor/%<id>s"
    clear_cfg = new_resource.clear_cfg
    uuid = new_resource.uuid
    link_enable_cfg = new_resource.link_enable_cfg
    link_up_cfg = new_resource.link_up_cfg
    link_down_cfg = new_resource.link_down_cfg
    user_tag = new_resource.user_tag
    link_disable_cfg = new_resource.link_disable_cfg
    monitor_relation = new_resource.monitor_relation
    id = new_resource.id

    params = { "monitor": {"clear-cfg": clear_cfg,
        "uuid": uuid,
        "link-enable-cfg": link_enable_cfg,
        "link-up-cfg": link_up_cfg,
        "link-down-cfg": link_down_cfg,
        "user-tag": user_tag,
        "link-disable-cfg": link_disable_cfg,
        "monitor-relation": monitor_relation,
        "id": id,} }

    params[:"monitor"].each do |k, v|
        if not v
            params[:"monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["monitor"].each do |k, v|
        if v != params[:"monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/monitor/%<id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end