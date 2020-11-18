class UrlClickIncrementer

  def initialize(url, params)
    @url = url
    @incrementer = params[:increment]
  end

  def call
    increment_click_count
  end

  private

  def increment_click_count
    @url.click_count += @incrementer
    @url.save
  end
end
