class VyrobniLinka < ApplicationRecord
  has_many :vyrobni_linka_polozkas

  def name
    nazev
  end
end
