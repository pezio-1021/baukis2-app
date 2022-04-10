class Admin::TopController < Admin::Base
  def index
    render action: "dashboard"
  end
end
