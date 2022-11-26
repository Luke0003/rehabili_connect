class Api::V1::PrefecturesController < ApplicationController
  def index
    prefectures = Prefecture.all
    render status: 200, json: { prefectures: prefectures }
  end
end
