class LocalFeature < ActiveRecord::Base
  include Brb::Model::Full
  include FeatureDescriptor
end
