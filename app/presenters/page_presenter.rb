class PagePresenter < BasePresenter
  presents :page
  delegate :title, to: :page

  def content
    h.raw page.content
  end

  def service_colour
    page.service.colour if page.service
  end
end
