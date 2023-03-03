class UserEventController < ApplicationController
  def new
  end

  def create
    @user_event = UserEvent.new(user_event_params)

    respond_to do |format|
      if @user_event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id, :attendance)
  end
end
