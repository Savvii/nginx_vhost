actions :enable, :disable

attribute :name, :name_attribute => true

attribute :domains,  :kind_of => Array,  :default => ["_"]
attribute :listen,   :kind_of => String, :default => "80" # alternatives: localhost:80 or unix:/striped/knitted.sock
attribute :root_path,:kind_of => String, :required => true

attribute :ssl_certificate_key, :kind_of => String
attribute :ssl_certificate,     :kind_of => String

attribute :log_dir,  :kind_of => String, :default => "/var/log/nginx/"
attribute :nginx_dir,:kind_of => String, :default => "/etc/nginx/"

def initialize(*args)
  super
  @action = :enable
end
