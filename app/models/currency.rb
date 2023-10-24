class Currency < ApplicationRecord
  validates_uniqueness_of :date, scope: %i[value char_code name nominal]
end
