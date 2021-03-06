class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.create(invitation_params.merge(inviter: current_user))
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = 'Your friend #{@invitation.recipient_name} has been invited.'
      redirect_to new_invitation_path
    else
      flash[:error] = 'Please check your inputs.'
      render :new 
    end
  end


  private

  def invitation_params
    params.require(:invitation).permit!
  end


end
