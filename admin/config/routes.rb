Gaku::Core::Engine.routes.draw  do

  concern :soft_delete do
    patch :recovery,    on: :member
    patch :soft_delete, on: :member
  end

  concern(:primary)         { patch :make_primary, on: :member }
  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }
  concern(:sort)            { post :sort, on: :collection }
  concern(:download)        { get :download, on: :member }

  resources :states, only: :index

  namespace :admin do

    get 'school_details',          to: 'schools#show_master'
    get 'school_details/edit',     to: 'schools#edit_master'
    patch 'school_details/update', to: 'schools#update_master'

    resources :schools do
      resources :programs, controller: 'schools/programs' do
        member do
          get :show_program_levels
          get :show_program_syllabuses
          get :show_program_specialties
        end
      end
      resources :campuses, controller: 'schools/campuses', except: :index do
        resources :contacts, controller: 'schools/campuses/contacts', except: %i( show index ), concerns: %i( soft_delete primary )

        resources :addresses, controller: 'schools/campuses/addresses', except: %i( show index )
      end
    end

    resources :simple_grade_types, controller: 'achievements/simple_grade_types'

    resources :badge_types
    resources :specialties
    resources :system_tools
    resources :commute_method_types
    resources :contact_types
    resources :enrollment_statuses
    resources :attendance_types
    resources :departments
    resources :users, concerns: %i( pagination )
    resources :roles
    resources :templates, except: %i( show ), concerns: %i( download )
    resources :grading_methods
    resources :grading_method_sets, concerns: %i( primary ) do
      resources :grading_method_set_items,
        controller: 'grading_method_sets/grading_method_set_items',
        concerns: %i( sort )
    end

    resources :states do
      post :country_states, on: :collection
    end

    resources :school_years do
      resources :semesters, controller: 'school_years/semesters', except: %i( show index )
    end

    resources :presets

  end
end
