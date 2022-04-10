class Staff::SessionsController < Staff::Base

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member =
        StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = "accout is anavailable"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "success login"
        redirect_to :staff_root
      end
    else 
      flash.now.alert = "Something went wrong"
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "success logout"
    redirect_to :staff_root
  end
  

  
end