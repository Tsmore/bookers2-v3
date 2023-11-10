class VideosController < ApplicationController

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id

    if @video.save
      VideoProcessingJob.perform_later(@video.id)
      flash[:notice] = "Video was successfully uploaded"
      redirect_to video_path(@video)
    else
      @videos = Video.all
      render :index
    end
  end
      # if @video.clip.attached?
      #   # Railsのtmpディレクトリを指定する
      #   output_dir = Rails.root.join('tmp', 'videos')
      #   FileUtils.mkdir_p(output_dir) unless File.directory?(output_dir)

      #   # ランダムなファイル名を生成する
      #   output_filename = "#{SecureRandom.hex}.mp4"
      #   output_path = File.join(output_dir, output_filename)

      #   # Active Storageのパスを取得
      #   clip_path = ActiveStorage::Blob.service.path_for(@video.clip.key)

      #   # FFmpegコマンドを構築
      #   ffmpeg_command = "ffmpeg -i #{clip_path} -vf scale=320:240 #{output_path}"

      #   # コンテナにファイルをコピーしてからFFmpegコマンドを実行
      #   system("docker cp #{clip_path} ffmpeg-container:/tmp/workdir/")
      #   system("docker exec ffmpeg-container #{ffmpeg_command}")
      #   system("docker cp ffmpeg-container:/tmp/workdir/#{File.basename(output_path)} #{output_path}")

      #   # 処理した動画をActive Storageにアタッチ
      #   processed_video = ActiveStorage::Blob.create_after_upload!(
      #     io: File.open(output_path),
      #     filename: File.basename(output_path),
      #     content_type: 'video/mp4'
      #   )
      #   @video.processed_clip.attach(processed_video)

      #   # 一時ファイルを削除する
      #   File.delete(output_path) if File.exist?(output_path)
      # end




  def show
    @video = Video.find(params[:id])
    @videonew = Video.new
  end

  def index
    @videos = Video.all
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      flash[:notice] = "video was successfully updated"
      redirect_to video_path(@video)
    else
      render :index
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path

  end

  private

  def video_params
    params.require(:video).permit(:title, :body, :category, :clip)
  end
end
