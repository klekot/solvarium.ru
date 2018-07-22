class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js
  enable_sync only: [:create, :update, :destroy]

  def index
    @messages_in  = Message.where(receiver: current_user.id)
    @messages_out = Message.where(sender:   current_user.id)
  end
  
  def new
    @new_message  = current_user.messages.build
    @receiver_id  = params[:receiver]
  end

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      sync_new @message
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Ваше сообщение отправлено.' }
      format.json { render json: @message }
    end

    # respond_with { @message }
  end

  private

  def message_params
    params.require(:message).permit(:body, :sender, :receiver)
  end
end