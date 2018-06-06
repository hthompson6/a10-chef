resource_name :a10_web_category_category_list

property :a10_name, String, name_property: true
property :streaming_media, [true, false]
property :weapons, [true, false]
property :uuid, String
property :entertainment_and_arts, [true, false]
property :cdns, [true, false]
property :financial_services, [true, false]
property :social_network, [true, false]
property :government, [true, false]
property :web_advertisements, [true, false]
property :fashion_and_beauty, [true, false]
property :computer_and_internet_security, [true, false]
property :real_estate, [true, false]
property :user_tag, String
property :web_based_email, [true, false]
property :sampling_enable, Array
property :recreation_and_hobbies, [true, false]
property :business_and_economy, [true, false]
property :confirmed_spam_sources, [true, false]
property :philosophy_and_politics, [true, false]
property :society, [true, false]
property :motor_vehicles, [true, false]
property :proxy_avoid_and_anonymizers, [true, false]
property :gross, [true, false]
property :legal, [true, false]
property :bot_nets, [true, false]
property :religion, [true, false]
property :private_ip_addresses, [true, false]
property :dating, [true, false]
property :pay_to_surf, [true, false]
property :reference_and_research, [true, false]
property :keyloggers_and_monitoring, [true, false]
property :kids, [true, false]
property :online_greeting_cards, [true, false]
property :violence, [true, false]
property :games, [true, false]
property :auctions, [true, false]
property :military, [true, false]
property :alcohol_and_tobacco, [true, false]
property :stock_advice_and_tools, [true, false]
property :news_and_media, [true, false]
property :cult_and_occult, [true, false]
property :food_and_dining, [true, false]
property :cheating, [true, false]
property :illegal, [true, false]
property :local_information, [true, false]
property :sports, [true, false]
property :music, [true, false]
property :shareware_and_freeware, [true, false]
property :spyware_and_adware, [true, false]
property :questionable, [true, false]
property :shopping, [true, false]
property :drugs, [true, false]
property :web_hosting_sites, [true, false]
property :malware_sites, [true, false]
property :dynamic_comment, [true, false]
property :translation, [true, false]
property :job_search, [true, false]
property :hunting_and_fishing, [true, false]
property :search_engines, [true, false]
property :educational_institutions, [true, false]
property :internet_portals, [true, false]
property :computer_and_internet_info, [true, false]
property :abortion, [true, false]
property :hacking, [true, false]
property :adult_and_pornography, [true, false]
property :phishing_and_other_fraud, [true, false]
property :nudity, [true, false]
property :health_and_medicine, [true, false]
property :marijuana, [true, false]
property :home_and_garden, [true, false]
property :personal_storage, [true, false]
property :sex_education, [true, false]
property :swimsuits_and_intimate_apparel, [true, false]
property :dead_sites, [true, false]
property :travel, [true, false]
property :hate_and_racism, [true, false]
property :open_http_proxies, [true, false]
property :internet_communications, [true, false]
property :gambling, [true, false]
property :peer_to_peer, [true, false]
property :uncategorized, [true, false]
property :personal_sites_and_blogs, [true, false]
property :spam_urls, [true, false]
property :unconfirmed_spam_sources, [true, false]
property :image_and_video_search, [true, false]
property :training_and_tools, [true, false]
property :parked_domains, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/web-category/category-list/"
    get_url = "/axapi/v3/web-category/category-list/%<name>s"
    streaming_media = new_resource.streaming_media
    weapons = new_resource.weapons
    uuid = new_resource.uuid
    entertainment_and_arts = new_resource.entertainment_and_arts
    cdns = new_resource.cdns
    financial_services = new_resource.financial_services
    social_network = new_resource.social_network
    government = new_resource.government
    web_advertisements = new_resource.web_advertisements
    fashion_and_beauty = new_resource.fashion_and_beauty
    computer_and_internet_security = new_resource.computer_and_internet_security
    a10_name = new_resource.a10_name
    real_estate = new_resource.real_estate
    user_tag = new_resource.user_tag
    web_based_email = new_resource.web_based_email
    sampling_enable = new_resource.sampling_enable
    recreation_and_hobbies = new_resource.recreation_and_hobbies
    business_and_economy = new_resource.business_and_economy
    confirmed_spam_sources = new_resource.confirmed_spam_sources
    philosophy_and_politics = new_resource.philosophy_and_politics
    society = new_resource.society
    motor_vehicles = new_resource.motor_vehicles
    proxy_avoid_and_anonymizers = new_resource.proxy_avoid_and_anonymizers
    gross = new_resource.gross
    legal = new_resource.legal
    bot_nets = new_resource.bot_nets
    religion = new_resource.religion
    private_ip_addresses = new_resource.private_ip_addresses
    dating = new_resource.dating
    pay_to_surf = new_resource.pay_to_surf
    reference_and_research = new_resource.reference_and_research
    keyloggers_and_monitoring = new_resource.keyloggers_and_monitoring
    kids = new_resource.kids
    online_greeting_cards = new_resource.online_greeting_cards
    violence = new_resource.violence
    games = new_resource.games
    auctions = new_resource.auctions
    military = new_resource.military
    alcohol_and_tobacco = new_resource.alcohol_and_tobacco
    stock_advice_and_tools = new_resource.stock_advice_and_tools
    news_and_media = new_resource.news_and_media
    cult_and_occult = new_resource.cult_and_occult
    food_and_dining = new_resource.food_and_dining
    cheating = new_resource.cheating
    illegal = new_resource.illegal
    local_information = new_resource.local_information
    sports = new_resource.sports
    music = new_resource.music
    shareware_and_freeware = new_resource.shareware_and_freeware
    spyware_and_adware = new_resource.spyware_and_adware
    questionable = new_resource.questionable
    shopping = new_resource.shopping
    drugs = new_resource.drugs
    web_hosting_sites = new_resource.web_hosting_sites
    malware_sites = new_resource.malware_sites
    dynamic_comment = new_resource.dynamic_comment
    translation = new_resource.translation
    job_search = new_resource.job_search
    hunting_and_fishing = new_resource.hunting_and_fishing
    search_engines = new_resource.search_engines
    educational_institutions = new_resource.educational_institutions
    internet_portals = new_resource.internet_portals
    computer_and_internet_info = new_resource.computer_and_internet_info
    abortion = new_resource.abortion
    hacking = new_resource.hacking
    adult_and_pornography = new_resource.adult_and_pornography
    phishing_and_other_fraud = new_resource.phishing_and_other_fraud
    nudity = new_resource.nudity
    health_and_medicine = new_resource.health_and_medicine
    marijuana = new_resource.marijuana
    home_and_garden = new_resource.home_and_garden
    personal_storage = new_resource.personal_storage
    sex_education = new_resource.sex_education
    swimsuits_and_intimate_apparel = new_resource.swimsuits_and_intimate_apparel
    dead_sites = new_resource.dead_sites
    travel = new_resource.travel
    hate_and_racism = new_resource.hate_and_racism
    open_http_proxies = new_resource.open_http_proxies
    internet_communications = new_resource.internet_communications
    gambling = new_resource.gambling
    peer_to_peer = new_resource.peer_to_peer
    uncategorized = new_resource.uncategorized
    personal_sites_and_blogs = new_resource.personal_sites_and_blogs
    spam_urls = new_resource.spam_urls
    unconfirmed_spam_sources = new_resource.unconfirmed_spam_sources
    image_and_video_search = new_resource.image_and_video_search
    training_and_tools = new_resource.training_and_tools
    parked_domains = new_resource.parked_domains

    params = { "category-list": {"streaming-media": streaming_media,
        "weapons": weapons,
        "uuid": uuid,
        "entertainment-and-arts": entertainment_and_arts,
        "cdns": cdns,
        "financial-services": financial_services,
        "social-network": social_network,
        "government": government,
        "web-advertisements": web_advertisements,
        "fashion-and-beauty": fashion_and_beauty,
        "computer-and-internet-security": computer_and_internet_security,
        "name": a10_name,
        "real-estate": real_estate,
        "user-tag": user_tag,
        "web-based-email": web_based_email,
        "sampling-enable": sampling_enable,
        "recreation-and-hobbies": recreation_and_hobbies,
        "business-and-economy": business_and_economy,
        "confirmed-spam-sources": confirmed_spam_sources,
        "philosophy-and-politics": philosophy_and_politics,
        "society": society,
        "motor-vehicles": motor_vehicles,
        "proxy-avoid-and-anonymizers": proxy_avoid_and_anonymizers,
        "gross": gross,
        "legal": legal,
        "bot-nets": bot_nets,
        "religion": religion,
        "private-ip-addresses": private_ip_addresses,
        "dating": dating,
        "pay-to-surf": pay_to_surf,
        "reference-and-research": reference_and_research,
        "keyloggers-and-monitoring": keyloggers_and_monitoring,
        "kids": kids,
        "online-greeting-cards": online_greeting_cards,
        "violence": violence,
        "games": games,
        "auctions": auctions,
        "military": military,
        "alcohol-and-tobacco": alcohol_and_tobacco,
        "stock-advice-and-tools": stock_advice_and_tools,
        "news-and-media": news_and_media,
        "cult-and-occult": cult_and_occult,
        "food-and-dining": food_and_dining,
        "cheating": cheating,
        "illegal": illegal,
        "local-information": local_information,
        "sports": sports,
        "music": music,
        "shareware-and-freeware": shareware_and_freeware,
        "spyware-and-adware": spyware_and_adware,
        "questionable": questionable,
        "shopping": shopping,
        "drugs": drugs,
        "web-hosting-sites": web_hosting_sites,
        "malware-sites": malware_sites,
        "dynamic-comment": dynamic_comment,
        "translation": translation,
        "job-search": job_search,
        "hunting-and-fishing": hunting_and_fishing,
        "search-engines": search_engines,
        "educational-institutions": educational_institutions,
        "internet-portals": internet_portals,
        "computer-and-internet-info": computer_and_internet_info,
        "abortion": abortion,
        "hacking": hacking,
        "adult-and-pornography": adult_and_pornography,
        "phishing-and-other-fraud": phishing_and_other_fraud,
        "nudity": nudity,
        "health-and-medicine": health_and_medicine,
        "marijuana": marijuana,
        "home-and-garden": home_and_garden,
        "personal-storage": personal_storage,
        "sex-education": sex_education,
        "swimsuits-and-intimate-apparel": swimsuits_and_intimate_apparel,
        "dead-sites": dead_sites,
        "travel": travel,
        "hate-and-racism": hate_and_racism,
        "open-http-proxies": open_http_proxies,
        "internet-communications": internet_communications,
        "gambling": gambling,
        "peer-to-peer": peer_to_peer,
        "uncategorized": uncategorized,
        "personal-sites-and-blogs": personal_sites_and_blogs,
        "spam-urls": spam_urls,
        "unconfirmed-spam-sources": unconfirmed_spam_sources,
        "image-and-video-search": image_and_video_search,
        "training-and-tools": training_and_tools,
        "parked-domains": parked_domains,} }

    params[:"category-list"].each do |k, v|
        if not v 
            params[:"category-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating category-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category/category-list/%<name>s"
    streaming_media = new_resource.streaming_media
    weapons = new_resource.weapons
    uuid = new_resource.uuid
    entertainment_and_arts = new_resource.entertainment_and_arts
    cdns = new_resource.cdns
    financial_services = new_resource.financial_services
    social_network = new_resource.social_network
    government = new_resource.government
    web_advertisements = new_resource.web_advertisements
    fashion_and_beauty = new_resource.fashion_and_beauty
    computer_and_internet_security = new_resource.computer_and_internet_security
    a10_name = new_resource.a10_name
    real_estate = new_resource.real_estate
    user_tag = new_resource.user_tag
    web_based_email = new_resource.web_based_email
    sampling_enable = new_resource.sampling_enable
    recreation_and_hobbies = new_resource.recreation_and_hobbies
    business_and_economy = new_resource.business_and_economy
    confirmed_spam_sources = new_resource.confirmed_spam_sources
    philosophy_and_politics = new_resource.philosophy_and_politics
    society = new_resource.society
    motor_vehicles = new_resource.motor_vehicles
    proxy_avoid_and_anonymizers = new_resource.proxy_avoid_and_anonymizers
    gross = new_resource.gross
    legal = new_resource.legal
    bot_nets = new_resource.bot_nets
    religion = new_resource.religion
    private_ip_addresses = new_resource.private_ip_addresses
    dating = new_resource.dating
    pay_to_surf = new_resource.pay_to_surf
    reference_and_research = new_resource.reference_and_research
    keyloggers_and_monitoring = new_resource.keyloggers_and_monitoring
    kids = new_resource.kids
    online_greeting_cards = new_resource.online_greeting_cards
    violence = new_resource.violence
    games = new_resource.games
    auctions = new_resource.auctions
    military = new_resource.military
    alcohol_and_tobacco = new_resource.alcohol_and_tobacco
    stock_advice_and_tools = new_resource.stock_advice_and_tools
    news_and_media = new_resource.news_and_media
    cult_and_occult = new_resource.cult_and_occult
    food_and_dining = new_resource.food_and_dining
    cheating = new_resource.cheating
    illegal = new_resource.illegal
    local_information = new_resource.local_information
    sports = new_resource.sports
    music = new_resource.music
    shareware_and_freeware = new_resource.shareware_and_freeware
    spyware_and_adware = new_resource.spyware_and_adware
    questionable = new_resource.questionable
    shopping = new_resource.shopping
    drugs = new_resource.drugs
    web_hosting_sites = new_resource.web_hosting_sites
    malware_sites = new_resource.malware_sites
    dynamic_comment = new_resource.dynamic_comment
    translation = new_resource.translation
    job_search = new_resource.job_search
    hunting_and_fishing = new_resource.hunting_and_fishing
    search_engines = new_resource.search_engines
    educational_institutions = new_resource.educational_institutions
    internet_portals = new_resource.internet_portals
    computer_and_internet_info = new_resource.computer_and_internet_info
    abortion = new_resource.abortion
    hacking = new_resource.hacking
    adult_and_pornography = new_resource.adult_and_pornography
    phishing_and_other_fraud = new_resource.phishing_and_other_fraud
    nudity = new_resource.nudity
    health_and_medicine = new_resource.health_and_medicine
    marijuana = new_resource.marijuana
    home_and_garden = new_resource.home_and_garden
    personal_storage = new_resource.personal_storage
    sex_education = new_resource.sex_education
    swimsuits_and_intimate_apparel = new_resource.swimsuits_and_intimate_apparel
    dead_sites = new_resource.dead_sites
    travel = new_resource.travel
    hate_and_racism = new_resource.hate_and_racism
    open_http_proxies = new_resource.open_http_proxies
    internet_communications = new_resource.internet_communications
    gambling = new_resource.gambling
    peer_to_peer = new_resource.peer_to_peer
    uncategorized = new_resource.uncategorized
    personal_sites_and_blogs = new_resource.personal_sites_and_blogs
    spam_urls = new_resource.spam_urls
    unconfirmed_spam_sources = new_resource.unconfirmed_spam_sources
    image_and_video_search = new_resource.image_and_video_search
    training_and_tools = new_resource.training_and_tools
    parked_domains = new_resource.parked_domains

    params = { "category-list": {"streaming-media": streaming_media,
        "weapons": weapons,
        "uuid": uuid,
        "entertainment-and-arts": entertainment_and_arts,
        "cdns": cdns,
        "financial-services": financial_services,
        "social-network": social_network,
        "government": government,
        "web-advertisements": web_advertisements,
        "fashion-and-beauty": fashion_and_beauty,
        "computer-and-internet-security": computer_and_internet_security,
        "name": a10_name,
        "real-estate": real_estate,
        "user-tag": user_tag,
        "web-based-email": web_based_email,
        "sampling-enable": sampling_enable,
        "recreation-and-hobbies": recreation_and_hobbies,
        "business-and-economy": business_and_economy,
        "confirmed-spam-sources": confirmed_spam_sources,
        "philosophy-and-politics": philosophy_and_politics,
        "society": society,
        "motor-vehicles": motor_vehicles,
        "proxy-avoid-and-anonymizers": proxy_avoid_and_anonymizers,
        "gross": gross,
        "legal": legal,
        "bot-nets": bot_nets,
        "religion": religion,
        "private-ip-addresses": private_ip_addresses,
        "dating": dating,
        "pay-to-surf": pay_to_surf,
        "reference-and-research": reference_and_research,
        "keyloggers-and-monitoring": keyloggers_and_monitoring,
        "kids": kids,
        "online-greeting-cards": online_greeting_cards,
        "violence": violence,
        "games": games,
        "auctions": auctions,
        "military": military,
        "alcohol-and-tobacco": alcohol_and_tobacco,
        "stock-advice-and-tools": stock_advice_and_tools,
        "news-and-media": news_and_media,
        "cult-and-occult": cult_and_occult,
        "food-and-dining": food_and_dining,
        "cheating": cheating,
        "illegal": illegal,
        "local-information": local_information,
        "sports": sports,
        "music": music,
        "shareware-and-freeware": shareware_and_freeware,
        "spyware-and-adware": spyware_and_adware,
        "questionable": questionable,
        "shopping": shopping,
        "drugs": drugs,
        "web-hosting-sites": web_hosting_sites,
        "malware-sites": malware_sites,
        "dynamic-comment": dynamic_comment,
        "translation": translation,
        "job-search": job_search,
        "hunting-and-fishing": hunting_and_fishing,
        "search-engines": search_engines,
        "educational-institutions": educational_institutions,
        "internet-portals": internet_portals,
        "computer-and-internet-info": computer_and_internet_info,
        "abortion": abortion,
        "hacking": hacking,
        "adult-and-pornography": adult_and_pornography,
        "phishing-and-other-fraud": phishing_and_other_fraud,
        "nudity": nudity,
        "health-and-medicine": health_and_medicine,
        "marijuana": marijuana,
        "home-and-garden": home_and_garden,
        "personal-storage": personal_storage,
        "sex-education": sex_education,
        "swimsuits-and-intimate-apparel": swimsuits_and_intimate_apparel,
        "dead-sites": dead_sites,
        "travel": travel,
        "hate-and-racism": hate_and_racism,
        "open-http-proxies": open_http_proxies,
        "internet-communications": internet_communications,
        "gambling": gambling,
        "peer-to-peer": peer_to_peer,
        "uncategorized": uncategorized,
        "personal-sites-and-blogs": personal_sites_and_blogs,
        "spam-urls": spam_urls,
        "unconfirmed-spam-sources": unconfirmed_spam_sources,
        "image-and-video-search": image_and_video_search,
        "training-and-tools": training_and_tools,
        "parked-domains": parked_domains,} }

    params[:"category-list"].each do |k, v|
        if not v
            params[:"category-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["category-list"].each do |k, v|
        if v != params[:"category-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating category-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-category/category-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting category-list') do
            client.delete(url)
        end
    end
end