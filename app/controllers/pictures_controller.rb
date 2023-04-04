class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
    redirect_to pictures_path,notice: "#{current_user.name}さんがブログを作成しました！"
    else
      render :new
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "#{current_user.name}さんがブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice: "#{current_user.name}さんがブログを削除しました！"
  end

  def confirm
    @picture = Picture.new(picture_params)
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :content, :image_cache)
  end

end
