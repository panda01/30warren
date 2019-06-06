class View < ActiveRecord::Base
  include Brb::Model::Full
  include FeatureDescriptor
end
