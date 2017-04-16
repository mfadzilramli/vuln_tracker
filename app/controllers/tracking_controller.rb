class TrackingController < ApplicationController

  def import
    if !params[:tracking].nil?
      params[:tracking]['data'].each do |t|
        Tracking.update_remedy_action(t)
      end
      redirect_to root_path
    else
      redirect_to tracking_path
    end
  end

  def index
  end

end
