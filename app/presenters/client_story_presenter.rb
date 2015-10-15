class ClientStoryPresenter < BasePresenter
  presents :client_story
  delegate :title, to: :client_story

  def service_colour
    client_story.service.colour
  end

  def summary
    h.simple_format client_story.summary
  end

  def content
    h.raw client_story.content
  end

  def read_more
    return nil unless client_story.content.present?
    h.link_to 'Read more', h.service_client_story_path(client_story.service.id, client_story.id), class: "client-story-read-more #{client_story.service.colour}", title: "Read more #{title}"
  end

  def date(format = :default)
    h.l client_story.date, format: format
  end

  def linked_index_image
    if client_story.content.blank? && client_story.image.present?
      index_image(alt: title, class: 'image-right')
    elsif client_story.content.present? && client_story.image.present?
      h.link_to index_image(alt: title, class: 'image-right'), h.service_client_story_path(client_story.service.id, client_story.id)
    end
  end
end
