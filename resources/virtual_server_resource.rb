resource_name :a10_virtual_server

property :name, String
property :ip_address, String
property :url, String

action :create do
    client = client
end

action :update do
end

action :delete do
end

action_class do
    include A10Chef
end
