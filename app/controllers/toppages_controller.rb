class ToppagesController < ApplicationController
  def index
    #取得したItemのデータの更新日をキーにして降順に並び替える
    @items = Item.order('updated_at DESC')
  end
end
