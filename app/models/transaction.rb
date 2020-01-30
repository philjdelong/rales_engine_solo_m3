class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :successful, -> { where(result: "success") }

  def credit_card_number
    self["credit_card_number"].to_s
  end
end
