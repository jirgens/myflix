class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.create(invitation_params.merge(inviter: current_user))
    AppMailer.send_invitation_email(@invitation).deliver
    if @invitation.save
      flash[:success] = 'Your friend #{@invitation.recipient_name} has been invited.'
      redirect_to new_invitation_path
    else
      flash[:danger] = 'Please check your inputs.'
      render :new 
    end
  end


  private

  def invitation_params
    params.fetch(:invitation, {}).permit(:recipient_name, :recipient_email, :message, :inviter_id)
  end


end

 # line 9 invitation = Invitation.create(invitation_params.merge!(inviter_id: current_user.id))