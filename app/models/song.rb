class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title,  uniqueness: { scope: [:release_year, :artist_name] }
  validates_inclusion_of :released, in: [true, false]
  validates :artist_name, presence: true
  # validates :release_year, presence: true, numericality: { less_than_or_equal_to: Date.today.year }, if: :released

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: { 
      less_than_or_equal_to: Date.today.year
    }
  end 

  def released?
    released
  end
end

