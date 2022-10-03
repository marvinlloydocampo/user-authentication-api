# Should need to add code here to connect for Production Redis if need to deploy
require 'connection_pool'
Ohm.redis = Redic.new("redis://127.0.0.1:6379")