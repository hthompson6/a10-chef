resource_name :a10_rename

property :a10_name, String, name_property: true
property :object, String
property :instance_name, String
property :new_instance_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/rename"
    object = new_resource.object
    instance_name = new_resource.instance_name
    new_instance_name = new_resource.new_instance_name

    params = { "rename": {"object": object,
        "instance-name": instance_name,
        "new-instance-name": new_instance_name,} }

    params[:"rename"].each do |k, v|
        if not v 
            params[:"rename"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rename') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rename"
    object = new_resource.object
    instance_name = new_resource.instance_name
    new_instance_name = new_resource.new_instance_name

    params = { "rename": {"object": object,
        "instance-name": instance_name,
        "new-instance-name": new_instance_name,} }

    params[:"rename"].each do |k, v|
        if not v
            params[:"rename"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rename"].each do |k, v|
        if v != params[:"rename"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rename') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rename"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rename') do
            client.delete(url)
        end
    end
end