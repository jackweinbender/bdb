require 'json'

class Api::PagesController < ApplicationController
  def index
    data = File.read('db/data/pages.json')
    render json: JSON.parse(data)
  end
end
