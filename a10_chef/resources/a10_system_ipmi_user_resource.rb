resource_name :a10_system_ipmi_user

property :a10_name, String, name_property: true
property :administrator, [true, false]
property :setname, String
property :newname, String
property :newpass, String
property :callback, [true, false]
property :add, String
property :disable, String
property :setpass, String
property :user, [true, false]
property :operator, [true, false]
property :password, String
property :privilege, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/ipmi/"
    get_url = "/axapi/v3/system/ipmi/user"
    administrator = new_resource.administrator
    setname = new_resource.setname
    newname = new_resource.newname
    newpass = new_resource.newpass
    callback = new_resource.callback
    add = new_resource.add
    disable = new_resource.disable
    setpass = new_resource.setpass
    user = new_resource.user
    operator = new_resource.operator
    password = new_resource.password
    privilege = new_resource.privilege

    params = { "user": {"administrator": administrator,
        "setname": setname,
        "newname": newname,
        "newpass": newpass,
        "callback": callback,
        "add": add,
        "disable": disable,
        "setpass": setpass,
        "user": user,
        "operator": operator,
        "password": password,
        "privilege": privilege,} }

    params[:"user"].each do |k, v|
        if not v 
            params[:"user"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating user') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/user"
    administrator = new_resource.administrator
    setname = new_resource.setname
    newname = new_resource.newname
    newpass = new_resource.newpass
    callback = new_resource.callback
    add = new_resource.add
    disable = new_resource.disable
    setpass = new_resource.setpass
    user = new_resource.user
    operator = new_resource.operator
    password = new_resource.password
    privilege = new_resource.privilege

    params = { "user": {"administrator": administrator,
        "setname": setname,
        "newname": newname,
        "newpass": newpass,
        "callback": callback,
        "add": add,
        "disable": disable,
        "setpass": setpass,
        "user": user,
        "operator": operator,
        "password": password,
        "privilege": privilege,} }

    params[:"user"].each do |k, v|
        if not v
            params[:"user"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["user"].each do |k, v|
        if v != params[:"user"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating user') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/user"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting user') do
            client.delete(url)
        end
    end
end