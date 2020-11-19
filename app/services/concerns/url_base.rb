module UrlBase
  # I decided to move the CHARACTERS constant that was in the short_url model to this module because it needs to be
  # reused by the encoder and decoder services. Also I decided to use a module and not a parent class because it might
  # be needed for other models or services as well.
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  BASE = 62
end