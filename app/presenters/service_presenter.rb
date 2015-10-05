class ServicePresenter < BasePresenter
  presents :service
  delegate :name, :colour, to: :service
end
