module Signup
  class MembersController < BaseController
    def new
      if session[:member_id]
        redirect_to(next_signup_step) && return
      end
      @member = Member.new
      activate_member_step
    end

    def create
      @member = Member.new(member_params)

      if @member.save
        session[:member_id] = @member.id
        session[:timeout] = Time.current + 15.minutes

        redirect_to next_signup_step
      else
        activate_member_step
        render :new
      end
    end

    private

    def member_params
      params.require(:member).permit(:full_name, :preferred_name, :email, :pronoun, :custom_pronoun, :phone_number, :id_kind, :other_id_kind, :postal_code)
    end
  end
end
