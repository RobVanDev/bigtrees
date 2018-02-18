class MainController < ApplicationController

def show
  if page_is_valid?
     render template: "main/#{params[:page]}"
  else
     render file: "public/404.html", status: :not_found
  end
end

private
  def page_is_valid?
    File.exist?(Pathname.new(Rails.root + "app/views/main/#{params[:page]}.html.erb"))
  end

end
