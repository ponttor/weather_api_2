Rails.application.routes.draw do
  root "welcome#index"
  get 'health', to: 'weather#health'

  scope :weather do
    get 'current', to: 'weather#current'
    get 'historical', to: 'weather#each_hour'

    scope :historical do
      get 'max', to: 'weather#max'
      get 'min', to: 'weather#min'
      get 'avg', to: 'weather#avg'
      post 'by_time', to: 'weather#by_time'
    end
  end

end
