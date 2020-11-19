class UrlFetcher
  def initialize(url)
    @url = url
  end

  def call
    # We can fetch other meta data here if we need to e.g description, favicon, images, etc
    fetch_title
    update_model
  end

  private

  def fetch_title
    # Rescues any exception thrown by the LinkThumbnailer gem
    begin
      @url.title = LinkThumbnailer.generate(@url.full_url).title
    rescue LinkThumbnailer::Exceptions => e
      Rails.logger.error "Title from #{@url.full_url} could not be fetched. Details: #{e.inspect}"
    end
  end

  def update_model
    @url.save
  end
end
