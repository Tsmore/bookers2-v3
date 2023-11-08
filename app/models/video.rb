class Video < ApplicationRecord
  belongs_to :user
  has_one_attached :clip

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :category, presence: true
  validates :clip, presence: true

  validate :clip_type

  private

  def clip_type
    if clip.attached? && !clip.content_type.in?(%w(video/mp4 video/mov video/avi))
      errors.add(:clip, 'はMP4、MOV、またはAVI形式でなければなりません。')
    end
  end
end