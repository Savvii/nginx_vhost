bag = node.nginx.vhost.data_bag_name

data_bag(bag).each do |instance|
  instance_data = data_bag_item( bag, instance )

  nginx_vhost instance do
    instance_data.each do |attribute,value|
      case attribute
      when "id"
      when "domains"
        prefixed_domains = []
        ["", "www.", "*."].each do |prefix|
          value.each do |domain|
            prefixed_domains << prefix + domain
          end
        end
        domains prefixed_domains
      else
        send(attribute, value)
      end
    end
  end
end
