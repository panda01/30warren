class OrderPagesInCorrectPosition < ActiveRecord::Migration

  class Page < ActiveRecord::Base
  end

  def up
    %i[
      building
      residences
      neighborhood
      the-team
      gallery
      contact
      availability
      press
      legal
      colophon
      home
    ].each_with_index do |slug, i|
      Page.where(slug: slug).update_all(position: i)
    end
  end

  def down
  end
end
