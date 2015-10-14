class Service < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  has_many :client_stories, -> { displayed }
  has_many :pages, -> { displayed }
  has_one :contact_detail, -> { displayed }

  scope :positioned, -> { order(:position) }
  scope :displayed, -> { where(display: true) }

  validates :name, :colour, :question, presence: true, uniqueness: true
  validates :suggested_url, uniqueness: { message: "is already taken, leave blank to generate automatically" }, allow_blank: true, if: Proc.new{|x| x.suggested_url.present? }

  mount_uploader :image, ServiceUploader

  COLOURS = ['blue', 'green', 'turquoise', 'red', 'purple', 'yellow']
  validates :colour, inclusion: { in: COLOURS }

  def main_page
    pages.find_by("pages.service_main_page = ?", true)
  end

  def slug_candidates
    [
      :suggested_url,
      :name,
      [:suggested_url, :name]
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || suggested_url_changed? || name_changed?
  end
end
