def load_current_resource
  new_resource.nginx_dir
  new_resource.domains
  new_resource.listen
  new_resource.site_root
  new_resource.ssl_certificate_key
  new_resource.ssl_certificate
  new_resource.includes
end

action :enable do
  [new_resource.nginx_dir,
  ::File.join(new_resource.nginx_dir, "sites-enabled"),
  ::File.join(new_resource.nginx_dir, "sites-available"),
  ].each do |dir|
    directory dir  do
      recursive true
    end
  end

  name = new_resource.name

  template ::File.join(new_resource.nginx_dir, "sites-available", name) do
    source "vhost.conf.erb"
    mode "0644"
    owner "root"
    variables new_resource.to_hash
    notifies     :reload, "service[nginx]"
  end

  link ::File.join(new_resource.nginx_dir, "sites-enabled", name) do
    to ::File.join(new_resource.nginx_dir, "sites-available", name)
  end

  new_resource.updated_by_last_action(true)
end

action :disable do
  link ::File.join(new_resource.nginx_dir, "sites-available", name) do
    action :delete
    notifies     :reload, "service[nginx]"
  end
  new_resource.updated_by_last_action(true)
end
