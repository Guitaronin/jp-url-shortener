class ShortUrl < ApplicationRecord
  validates :full_url, presence: true
  validates_with Validators::FullUrlValidator
  after_create :encode_short_code
  scope :top, -> (limit) { order(click_count: :desc).limit(limit) }

  def short_code
    encoder_service.call unless self.id.nil?
  end

  def update_title!
  end

  def public_attributes
    {
        title: self.title,
        full_url: self.full_url,
        short_code: self.short_code,
        click_count: self.click_count
    }
  end

  private

  def encode_short_code
    self.short_code = encoder_service.call
    self.save
  end

  def encoder_service
    UrlEncoder.new(self.id)
  end
end
