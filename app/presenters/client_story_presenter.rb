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

  def date(format = :default)
    h.l client_story.date, format: format
  end
end
