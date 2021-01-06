Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w(
  animate.css icomoon.css bootstrap.css flexslider.css \
  style.css magnific-popup.css modernizr-2.6.2.min.js \
  jquery.min.js jquery.easing.1.3.js bootstrap.min.js \
  jquery.waypoints.min.js main.js jquery.flexslider-min.js custom.js
)
