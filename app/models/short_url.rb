class ShortUrl < ApplicationRecord
  validates :full_url, presence: true
  validates_with Validators::FullUrlValidator
  before_create :normalize_url
  after_create :encode_short_code
  scope :top, -> (limit) { order(click_count: :desc).limit(limit) }

  def short_code
    # This method is encoding the ID record on the fly. There is one test in the test suite that manually updates the
    # ID of the record and then expects the short_code to be the correct one. I decided to leave this method as it
    # is because I do not foresee a real life scenario when the ID of a record manually changes and also because
    # updating information on a getter method is not a good practice
    encoder_service.call unless self.id.nil?
  end

  def update_title!
    # This method is meant to be called primarily by a background job
    UrlFetcher.new(self).call
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

  def normalize_url
    uri = URI.parse(self.full_url)
    self.full_url = "http://#{uri}" unless uri.scheme
  end

  def encode_short_code
    self.short_code = encoder_service.call
    self.save
  end

  def encoder_service
    UrlEncoder.new(self.id)
  end
end
