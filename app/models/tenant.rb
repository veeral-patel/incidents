class Tenant < ApplicationRecord
    validates :name, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9]+\z/ }

    after_create :create_tenant
    after_destroy :destroy_tenant

    private
        def create_tenant
            Apartment::Tenant.create(name)
        end

        def destroy_tenant
            Apartment::Tenant.drop(name)
        end
end
