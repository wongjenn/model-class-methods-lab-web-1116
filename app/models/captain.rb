class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats => :classifications).where("classifications.name = ?", 'Catamaran')
  end

  def self.sailors
    self.joins(:boats => :classifications).where("classifications.name = ?", 'Sailboat').distinct
  end

  def self.talented_seamen
    seamen_ids = self.sailors.pluck(:id) & self.motorboats.pluck(:id)
    self.where(id: seamen_ids)
  end

  def self.motorboats
    self.joins(:boats => :classifications).where("classifications.name = ?", 'Motorboat').distinct
  end

  def self.non_sailors
    self.where.not(id: sailors.ids)
  end
end
