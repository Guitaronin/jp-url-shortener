class ShortUrl < ApplicationRecord
  validates :full_url, presence: true
  validates_with Validators::FullUrlValidator
  after_create :encode_short_code

  def short_code
    UrlEncoder.new(self.id).call unless self.id.nil?
  end

  def update_title!
  end

  private

  def encode_short_code
    self.short_code = UrlEncoder.new(self.id).call
    self.save
  end
end
