class HomeController < ApplicationController

	before_action :set_link, only: [:redirect_main_url, :link_details, :make_expire]

	def index
	end

	def test

	end

	def generate_urls
		id = Link.shorten(params[:url])
		redirect_to action: :show, id: id
	end

	def show
		link = Link.find(params[:id])
		@tiny_url = "#{request.base_url}/#{link.short}"
		@admin_url = "#{request.base_url}/admin/#{link.short}"
	end

	def redirect_main_url
		if @link.present?
			@link.update_attribute(:clicked, @link.clicked + 1)
			redirect_to @link.url and return
		else
			render :file => "#{Rails.root}/public/404.html",  :status => 404
		end
	end

	def link_details
	end

	def make_expire
		@link.make_expired
		redirect_to action: :index
	end

	private 

	def set_link
		@link = if(params[:id])
			Link.where(:id => params[:id], :active => true).first
		else
			Link.where(:slug => params[:slug], :active => true).first
		end
	end

end
