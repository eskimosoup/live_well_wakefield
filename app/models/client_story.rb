class ClientStory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history, :scoped], scope: :service

  belongs_to :service
  has_many :pages


  scope :displayed, -> { where("display = ? and date <= ?", true, Date.today) }
  scope :home_highlight, -> { where(home_highlight: true).displayed }
  scope :positioned, -> { order(:position) }
  scope :service, -> (service_id) { where(service_id: service_id) if service_id.present? }

  validates :title, :summary, :service_id, :date, presence: true
  validates :suggested_url, uniqueness: { scope: :service_id, message: "is already taken, leave blank to generate automatically" }, allow_blank: true, if: Proc.new{|x| x.suggested_url.present? }

  mount_uploader :image, ClientStoryUploader

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
end
