class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    render json: { urls: ShortUrl.top(100).map(&:public_attributes) }, status: :ok
  end

  def create
    @url = ShortUrl.new(full_url: params[:full_url])

    if @url.save
      # Trigger the back ground job to do the async fetching
      UpdateTitleJob.perform_later(@url.id)
      render json: @url, status: :created
    else
      render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @url = ShortUrl.find_by(id: UrlDecoder.new(params[:id]).call)

    if @url
      UrlIncrementer.new(@url, increment: 1).call
      redirect_to @url.full_url
    else
      render json: {}, status: :not_found
    end
  end
end
