actions :enable, :disable

attribute :name, :name_attribute => true

attribute :domains,  :kind_of => Array,  :default => ["_"]
attribute :listen,   :kind_of => String, :default => "80" # alternatives: localhost:80 or unix:/striped/knitted.sock
attribute :site_root,:kind_of => String, :required => true

attribute :ssl_certificate_key, :kind_of => String
attribute :ssl_certificate,     :kind_of => String

attribute :nginx_dir,:kind_of => String, :default => "/etc/nginx/"
attribute :includes, :kind_of => Array,  :default => []

def initialize(*args)
  super
  @action = :enable
end
