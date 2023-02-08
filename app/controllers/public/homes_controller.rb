class Public::HomesController < ApplicationController
  def top
    @illustrations = Illustration.order('id DESC').limit(10)
  end

  def illustration_params
    params.require(:home).permit(:image)
  end

end
