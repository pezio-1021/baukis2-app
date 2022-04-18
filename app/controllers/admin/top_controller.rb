class Admin::TopController < Admin::Base
  skip_before.action :authorize
  def index
    render action: "dashboard"
  end
end
