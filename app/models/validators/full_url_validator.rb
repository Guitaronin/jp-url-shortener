class Validators::FullUrlValidator < ActiveModel::Validator
  VALID_URL_REGEX = /(^http[s]?:\/{2}|(^www)|(^\/{1,2}))/

  def validate(record)
    record.errors.add(:full_url, 'is not a valid url') unless valid?(record)
  end

  private

  def valid?(record)
    !record.full_url.blank? && record.full_url.match?(VALID_URL_REGEX)
  end
end
