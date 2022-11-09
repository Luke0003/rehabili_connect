class Therapist::HomesController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def top
    # 配列にページネーション機能を実装するために記述
    @clients = Kaminari.paginate_array(current_therapist.clients).page(params[:page])
  end
end