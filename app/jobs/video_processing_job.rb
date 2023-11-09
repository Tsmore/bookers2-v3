class VideoProcessingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
  
  def perform(video_id)
    video = Video.find(video_id)
    return unless video.clip.attached?
    
    # FFmpegの処理
    input_path = ActiveStorage::blob.service.path_for(video.clip.key)
    output_path = Rails.root.join('tmp', "#{SecureRandom.hex}.mp4")
    ffmpeg_command = "ffmpeg -i #{input_path} -vf 'scale=320:240' #{output_path}"
    
    # コマンドを実行
    system(ffmpeg_command)
    
    # 処理が完了した動画をActiveStorageにアタッチ
    video.processed_clip.attach(io: File.open(outout_path), filename: 'processed_video.mp4')
    
    # 一時ファイルの削除
    File.delete(output_path) if File.exists?(output_path)
    
  end
end
