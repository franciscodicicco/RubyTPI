class Note < ApplicationRecord
  belongs_to :book, inverse_of: :notes

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }, uniqueness: {scope: :book_id}
  validates :content, presence: true

  def to_s
    title
  end
end
