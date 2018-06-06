resource_name :a10_fw_active_rule_set

property :a10_name, String, name_property: true
property :session_aging, String
property :override_nat_aging, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/active-rule-set"
    session_aging = new_resource.session_aging
    override_nat_aging = new_resource.override_nat_aging
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "active-rule-set": {"session-aging": session_aging,
        "override-nat-aging": override_nat_aging,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"active-rule-set"].each do |k, v|
        if not v 
            params[:"active-rule-set"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating active-rule-set') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/active-rule-set"
    session_aging = new_resource.session_aging
    override_nat_aging = new_resource.override_nat_aging
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "active-rule-set": {"session-aging": session_aging,
        "override-nat-aging": override_nat_aging,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"active-rule-set"].each do |k, v|
        if not v
            params[:"active-rule-set"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["active-rule-set"].each do |k, v|
        if v != params[:"active-rule-set"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating active-rule-set') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/active-rule-set"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting active-rule-set') do
            client.delete(url)
        end
    end
end