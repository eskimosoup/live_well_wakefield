class ServicePresenter < BasePresenter
  presents :service
  delegate :name, to: :service
end
