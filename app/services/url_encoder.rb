class UrlEncoder
  include UrlBase

  def initialize(url_id)
    @url_id = url_id
    @remainders = []
  end

  def call
    convert_to_base_62
    convert_to_encoded_characters
  end

  private

  def convert_to_base_62
    quotient = @url_id

    while quotient > UrlBase::BASE
      @remainders << quotient % UrlBase::BASE
      quotient = quotient / UrlBase::BASE
    end

    @remainders << quotient
    @remainders.reverse!
  end

  def convert_to_encoded_characters
    @remainders.map{|remainder| UrlBase::CHARACTERS[remainder]}.join
  end
end