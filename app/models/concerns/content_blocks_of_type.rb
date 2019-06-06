module Concerns::ContentBlocksOfType
  extend ActiveSupport::Concern

  protected

  def content_blocks_of_type(type)
    content_blocks.select {|cb| cb.block_type == type.to_s.camelcase}
                  .map(&type)
  end

end
