class UrlDecoder
  include UrlBase

  def initialize(encoded_character)
    @encoded_character = encoded_character
    @decoded_numbers = []
  end

  def call
    convert_to_decoded_numbers
    convert_to_base_10
  end

  private

  def convert_to_decoded_numbers
    @decoded_numbers = @encoded_character.each_char.map{|character| UrlBase::CHARACTERS.index(character)}.reverse
  end

  def convert_to_base_10
    @decoded_numbers.each_with_index.map{|number, index| (UrlBase::BASE ** index) * number}.inject(:+)
  end
end