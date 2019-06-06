module ResourceAttribute
  extend ActiveSupport::Concern

  included do |base|
    base.class_variable_set("@@resource_attributes", {})
  end

  module ClassMethods

    def resource_attribute(name, klass)
      attr_accessor name
      resource_attributes[name] = klass
    end

    def resource_attributes
      class_variable_get("@@resource_attributes")
    end

  end

  def resource_attributes! scope: :null_scope
    self.class.resource_attributes.each do |name, klass|
      instance_variable_set("@#{name}", send(scope, klass).all)
    end
  end

  private

  def null_scope(resource)
    resource
  end

end
