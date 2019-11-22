class PurchaseOrder < ApplicationRecord
  # Đây là model cho yêu cầu nhập hàng. VD khi tạo một yêu cầu nhập hàng và ông chủ có thể phê duyệt để nhân viên đặt hàng có thể thực hiện đặt hàng

  belongs_to :user
  belongs_to :store
  belongs_to :supplier, optional: true
  has_many :product_purchase_orders, dependent: :delete_all
  has_many :products, through: :product_purchase_orders

  validates :name, presence: true, length: {minimum: 2, maximum: 64}
  validates :code, uniqueness: {scope: :store}, length: {minimum: 2, maximum: 32}, :allow_blank => true

  enum status: { created: 0, checking: 1, checked: 2, confirmed: 3 }
  scope :by_store, -> (store_id) { where(store_id: store_id) }
  self.per_page = 10
end
