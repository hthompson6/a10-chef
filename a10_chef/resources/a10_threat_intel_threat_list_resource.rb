resource_name :a10_threat_intel_threat_list

property :a10_name, String, name_property: true
property :web_attacks, [true, false]
property :botnets, [true, false]
property :spam_sources, [true, false]
property :windows_exploits, [true, false]
property :phishing, [true, false]
property :mobile_threats, [true, false]
property :tor_proxy, [true, false]
property :user_tag, String
property :sampling_enable, Array
property :reputation, [true, false]
property :proxy, [true, false]
property :dos_attacks, [true, false]
property :all_categories, [true, false]
property :ntype, ['webroot']
property :scanners, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/threat-intel/threat-list/"
    get_url = "/axapi/v3/threat-intel/threat-list/%<name>s"
    web_attacks = new_resource.web_attacks
    botnets = new_resource.botnets
    a10_name = new_resource.a10_name
    spam_sources = new_resource.spam_sources
    windows_exploits = new_resource.windows_exploits
    phishing = new_resource.phishing
    mobile_threats = new_resource.mobile_threats
    tor_proxy = new_resource.tor_proxy
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    reputation = new_resource.reputation
    proxy = new_resource.proxy
    dos_attacks = new_resource.dos_attacks
    all_categories = new_resource.all_categories
    ntype = new_resource.ntype
    scanners = new_resource.scanners
    uuid = new_resource.uuid

    params = { "threat-list": {"web-attacks": web_attacks,
        "botnets": botnets,
        "name": a10_name,
        "spam-sources": spam_sources,
        "windows-exploits": windows_exploits,
        "phishing": phishing,
        "mobile-threats": mobile_threats,
        "tor-proxy": tor_proxy,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "reputation": reputation,
        "proxy": proxy,
        "dos-attacks": dos_attacks,
        "all-categories": all_categories,
        "type": ntype,
        "scanners": scanners,
        "uuid": uuid,} }

    params[:"threat-list"].each do |k, v|
        if not v 
            params[:"threat-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating threat-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/threat-intel/threat-list/%<name>s"
    web_attacks = new_resource.web_attacks
    botnets = new_resource.botnets
    a10_name = new_resource.a10_name
    spam_sources = new_resource.spam_sources
    windows_exploits = new_resource.windows_exploits
    phishing = new_resource.phishing
    mobile_threats = new_resource.mobile_threats
    tor_proxy = new_resource.tor_proxy
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    reputation = new_resource.reputation
    proxy = new_resource.proxy
    dos_attacks = new_resource.dos_attacks
    all_categories = new_resource.all_categories
    ntype = new_resource.ntype
    scanners = new_resource.scanners
    uuid = new_resource.uuid

    params = { "threat-list": {"web-attacks": web_attacks,
        "botnets": botnets,
        "name": a10_name,
        "spam-sources": spam_sources,
        "windows-exploits": windows_exploits,
        "phishing": phishing,
        "mobile-threats": mobile_threats,
        "tor-proxy": tor_proxy,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "reputation": reputation,
        "proxy": proxy,
        "dos-attacks": dos_attacks,
        "all-categories": all_categories,
        "type": ntype,
        "scanners": scanners,
        "uuid": uuid,} }

    params[:"threat-list"].each do |k, v|
        if not v
            params[:"threat-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["threat-list"].each do |k, v|
        if v != params[:"threat-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating threat-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/threat-intel/threat-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting threat-list') do
            client.delete(url)
        end
    end
end