class Page < ActiveRecord::Base
  include MenuResourceable
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history, :scoped], scope: :service_id

  belongs_to :service
  belongs_to :client_story, -> { displayed }

  mount_uploader :image, PageUploader

  before_save :store_image, if: Proc.new{|page| page.remote_image_url.blank? }
  # before_save :store_file, if: Proc.new{|page| page.remote_file_url.blank? }

  scope :displayed, -> { where(display: true) }
  scope :service, -> (service_id) { where(service_id: service_id) if service_id.present? }

  validates :title, :content, presence: true
  validates :title, uniqueness: { scope: :service_id, message: 'already exists for this page' }
  validates :suggested_url, allow_blank: true, uniqueness: { scope: :service_id, message: 'is already taken, leave blank to generate automatically' }
  validates :service_main_page, presence: true, allow_blank: true, uniqueness: { scope: :service_id, message: 'is already set' }

  before_save :update_service_from_client_story, if: "self.client_story.present? && self.client_story.service != self.service"
  #before_save :update_page_name

  #def update_service_from_client_story
  #  self.service_id = self.client_story.service_id
  #end

  def update_page_name
    if self.service_id.present?
      self.name = "#{self.title} (#{self.service.name})"
    else
      self.name = self.title
    end
  end

  def slug_candidates
    [
      :suggested_url,
      :title,
      [:suggested_url, :title]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || title_changed?
  end

  def route
    "{:controller => '/pages', :action => 'show', :id => '#{self.slug}'}"
  end

  def self.layouts
    %w{ application }
  end

  def self.styles
    %w{ basic }
  end

  def store_image
    Optimadmin::Image.store_image(self, image) if image.present? && image_changed?
  end

  # def store_file
  #   Optimadmin::Document.store_file(self, file) if file.present? && file_changed?
  # end
end
