class Tag < ApplicationRecord
  belongs_to :article
  delegate :user, to: :article
end
