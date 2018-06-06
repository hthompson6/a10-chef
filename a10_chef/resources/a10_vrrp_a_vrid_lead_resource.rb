resource_name :a10_vrrp_a_vrid_lead

property :a10_name, String, name_property: true
property :vrid_lead_str, String,required: true
property :partition, Hash
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/vrid-lead/"
    get_url = "/axapi/v3/vrrp-a/vrid-lead/%<vrid-lead-str>s"
    vrid_lead_str = new_resource.vrid_lead_str
    partition = new_resource.partition
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "vrid-lead": {"vrid-lead-str": vrid_lead_str,
        "partition": partition,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"vrid-lead"].each do |k, v|
        if not v 
            params[:"vrid-lead"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vrid-lead') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid-lead/%<vrid-lead-str>s"
    vrid_lead_str = new_resource.vrid_lead_str
    partition = new_resource.partition
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "vrid-lead": {"vrid-lead-str": vrid_lead_str,
        "partition": partition,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"vrid-lead"].each do |k, v|
        if not v
            params[:"vrid-lead"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vrid-lead"].each do |k, v|
        if v != params[:"vrid-lead"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vrid-lead') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid-lead/%<vrid-lead-str>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vrid-lead') do
            client.delete(url)
        end
    end
end