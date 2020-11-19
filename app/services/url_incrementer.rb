class UrlIncrementer
  def initialize(url, params)
    @url = url
    @incrementer = params[:increment]
  end

  def call
    # We can increment other attributes here if wee ned to e.g users_count, visits_per_day, etc
    increment_click_count
    update_model
  end

  private

  def increment_click_count
    @url.click_count += @incrementer
  end

  def update_model
    @url.save
  end
end
