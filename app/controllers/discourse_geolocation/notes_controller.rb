module DiscourseGeolocation
  class NotesController < ::ApplicationController
    requires_plugin 'discourse-geolocation'

    def create
      note = GeoNote.new(
        title: params[:title],
        content: params[:content],
        longitude: params[:longitude],
        latitude: params[:latitude],
        user_id: params[:user_id],
      )

      if note.save
        render json: { success: true }
      else
        render json: { success: false }, status: 422
      end
    end
  end
end

# 위치 정보까지 + 디비에 저장 -> 기존에 방해 X
