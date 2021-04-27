require 'rails_helper'

RSpec.describe "Homes", type: :request do

	let(:url) {
		"https://mail.google.com/mail/u/0/#inbox"    
  }

  describe "GET /homes" do
    it "Generate Shotener URL for the given URL" do
    	post generate_urls_home_index_path(url: url)
      expect(response).to redirect_to(home_path(id: Link.last.id))
    end

    it "Should return false for empty URL" do 
    	post generate_urls_home_index_path(url: "")
      expect(response).to redirect_to(root_path)
    end

    it "Should return index for invalid URL" do 
    	post generate_urls_home_index_path(url: "xxx")
      expect(response).to redirect_to(root_path)
    end
  end

  describe "Shotener URL redirection" do

    it "Redirect to main URL after selecting Shotener URL" do
    	post generate_urls_home_index_path(url: url)
    	get "/s/#{Link.last.slug}"
      expect(response).to redirect_to(url)
    end

    it "Redirect to 404 error page if URL expired" do
    	post generate_urls_home_index_path(url: url)
    	get make_expire_home_index_path(slug: Link.last.slug)
    	get "/s/#{Link.last.slug}"
      expect(response.status).to eq(404)
    end
  end

  describe "Get number of clicks" do

  	it "should return 0 for never clicked" do
  		post generate_urls_home_index_path(url: url)
  		expect(Link.last.clicked).to eql(0)
  	end

  	it "should return 1 for first selection" do
  		post generate_urls_home_index_path(url: url)
  		get "/s/#{Link.last.slug}"
  		expect(Link.last.clicked).to eql(1)
  	end

  	it "should return 1 for first selection" do
  		post generate_urls_home_index_path(url: url)
  		5.times do 
  			get "/s/#{Link.last.slug}"
  		end
  		expect(Link.last.clicked).to eql(5)
  	end

  end
end
