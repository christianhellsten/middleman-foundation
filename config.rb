# Slim views
require 'slim'
# Change this
set :url_root, 'http://example.com'
set :frontmatter_extensions, %w(.html .json .slim .erb .haml)
set :slim, pretty: false
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :directory_indexes
activate :search_engine_sitemap
activate :livereload

helpers do
  def title(value)
    content_for :title, value
  end
end

bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))

compass_config do |config|
  config.add_import_path File.join('..', bower_config['directory'], 'foundation', 'scss')
  config.http_path = "/"
  config.css_dir = "stylesheets"
  config.sass_dir = "stylesheets"
  config.images_dir = "images"
  config.javascripts_dir = "javascripts"
end

# Add bower's directory to sprockets asset path
after_configuration do
  sprockets.append_path File.join "#{root}", bower_config["directory"]
end

# Build-specific configuration
set :build, false
configure :build do
  set :slim, pretty: true
  set :build, true
  activate :gzip, exts: %w(.js .css .json .html .htm)
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :imageoptim
end
