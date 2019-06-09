module Admin::Concerns::PermitParams
  extend ActiveSupport::Concern

  private

  def standalone_images_params
    {
      image_attributes: [
        image_params
      ]
    }
  end

  def image_params
    [
      :id,
      :attachment,
      :attachment_cache,
      :parent_id,
      :parent_type,
      :caption,
      :position,
      :width,
      :height,
      :content_type,
      :_destroy
    ]
  end

  ########################################
  ###### Content Blocks ##################
  ########################################

  def content_block_params
    {
      content_blocks_attributes: [
        :id,
        :_destroy,
        :parent_type,
        :parent_id,
        :position,
        :block_type,
        anchor_block_params,
        text_block_params,
        text_block_with_logo_params,
        file_block_params,
        feature_block_params,
        team_block_params,
        image_block_params,
        slideshow_block_params,
        video_block_params,
        map_block_params,
        panorama_block_params,
      ]
    }
  end

  def anchor_block_params
    {
      anchor_block_attributes: [
        :id,
        :title,
        :visible,
        :body
      ]
    }
  end

  def text_block_params
    {
      text_block_attributes: [
        :id,
        :title,
        :body
      ]
    }
  end

  def text_block_with_logo_params
    {
      text_block_with_logo_attributes: [
        :id,
        :title,
        :body,
        logo_attributes: [
          logo_params
        ]
      ]
    }
  end

  def file_block_params
    {
      file_block_attributes: [
        :id,
        :title,
        :subtitle,
        :body,
        :link_text,
        file_attributes: [
          image_params
        ]
      ]
    }
  end

  def team_block_params
    {
      team_block_attributes: [
        :id,
        :title,
        :subtitle,
        :body
      ]
    }
  end

  def feature_block_params
    {
      feature_block_attributes: [
        :id,
        :title,
        :body,
        :features,
        :width,
        :caption,
        :text_orientation,
        :subhead,
        image_attributes: [
          image_params
        ]
      ]
    }
  end

  def image_block_params
    {
      image_block_attributes: [
        :id,
        :title,
        :caption,
        :size,
        :treatment,
        :height_style,
        :enlargeable,
        :rendering,
        image_attributes: [
          image_params
        ]
      ]
    }
  end

  def slideshow_block_params
    {
      slideshow_block_attributes: [
        :id,
        :is_panorama,
        :contained,
        slides_attributes: [
          :id,
          :_destroy,
          :slide_type,
          :caption,
          :position,
          :video_url,
          :video_id,
          image_attributes: [
            image_params
          ]
        ]
      ]
    }
  end

  def video_block_params
    {
      video_block_attributes: [
        :id,
        :url,
        :video_id,
        :title,
        :caption
      ]
    }
  end

  def map_block_params
    {
      map_block_attributes: [
        :id,
        :title
      ]
    }
  end

  def panorama_block_params
    {
      panorama_block_attributes: [
        :id,
        :title,
        :caption
      ]
    }
  end

end
