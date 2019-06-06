require 'csv'

ActionController::Renderers.add :csv do |object, options|
  self.send_data object.to_csv, type: :csv
end
