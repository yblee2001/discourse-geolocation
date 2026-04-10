module DiscourseGeolocation
  class NotesController < ::ApplicationController
    requires_plugin 'discourse-geolocation'
    before_action :ensure_logged_in, only: [:nearby_users]

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

    def nearby_users
      lat = params[:latitude].to_f
      lng = params[:longitude].to_f
      radius_km = (params[:radius] || 10).to_f

      distance_sql = <<~SQL
        (6371 * acos(
          LEAST(1.0, GREATEST(-1.0,
            cos(radians(:lat)) * cos(radians(latitude)) *
            cos(radians(longitude) - radians(:lng)) +
            sin(radians(:lat)) * sin(radians(latitude))
          ))
        ))
      SQL

      notes = GeoNote
        .where.not(user_id: current_user.id)
        .where.not(latitude: nil)
        .where.not(longitude: nil)
        .where("#{distance_sql} <= :radius", lat: lat, lng: lng, radius: radius_km)
        .includes(:user)

      users_data = notes.group_by(&:user).map do |user, user_notes|
        {
          username: user.username,
          keywords: user_notes.map(&:content).compact.uniq
        }
      end

      render json: { nearby_users: users_data }
    end
  end
end

# 위치 정보까지 + 디비에 저장 -> 기존에 방해 X
