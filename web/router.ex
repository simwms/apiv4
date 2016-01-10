defmodule Apiv4.Router do
  use Apiv4.Web, :router
  ## Autox Installed
  import Autox.Manifest
  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug :fetch_session
    plug Autox.RepoContextPlug
    plug Autox.UnderscoreParamsPlug, "data"
  end
  ## End Autox
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Autox.AuthSessionPlug
    plug Autox.SessionContextPlug, session: :user, context: :parent
  end

  pipeline :account do
    plug Autox.AuthSessionPlug, {Apiv4.Permissions, :warehouse_employee?}
    plug Autox.SessionContextPlug, session: :account, context: :parent
  end

  pipeline :management do
    plug Autox.AuthSessionPlug, {Apiv4.Permissions, :warehouse_management?}
    plug Autox.SessionContextPlug, session: :account, context: :parent
  end

  pipeline :admin do
    plug Autox.AuthHeaderPlug, :simwms_master_key
  end

  pipeline :realtime do
    plug Autox.BroadcastSessionPlug, :account
  end

  pipeline :echo do
    plug Autox.RepoContextPlug, Autox.EchoRepo
  end

  pipeline :paranoia do
    plug Autox.RepoContextPlug, Autox.ParanoiaRepo
  end  

  scope "/print", Apiv4 do
    pipe_through [:browser, :echo] # Use the default browser stack
    the Report, [:show]
  end

  @moduledoc """
  Requires admin master key
  """
  scope "/admin", Apiv4 do
    pipe_through [:api, :admin]
    the ServicePlan, [:update, :create, :delete]
  end

  @moduledoc """
  requires user account management authorization
  """
  scope "/api", Apiv4 do
    pipe_through [:api, :auth, :account, :management, :realtime]    
    the Wall, [:create, :delete]
    the Road, [:create, :delete]
    the Gate, [:create, :delete]
    the Dock, [:create, :delete]
    the Cell, [:create, :delete]
    the Desk, [:create, :delete]
    the Scale, [:create, :delete]
    the Employee, [:create, :delete]
    an Account, [:delete, :update] do
      one ServicePlan, [:create, :delete]
    end
  end

  @moduledoc """
  requires user account authentication
  """
  scope "/api", Apiv4 do
    pipe_through [:api, :auth, :account, :realtime]
    the Wall, [:show, :index]
    the Road, [:show, :index]
    the Desk, [:show, :index], do: many [History, Camera]
    the Gate, [:show, :index], do: many [History, Camera]
    the Dock, [:show, :update, :index], do: many [History, Camera]
    the Cell, [:show, :update, :index], do: many [History, Camera]
    the Scale, [:show, :update, :index], do: many [History, Camera]
    the Truck, do: many [History, Picture]
    the Batch, do: many [History, Picture]
    the Weighticket
    the Employee, [:show, :index, :update], do: many [History, Picture]
    the Company do
      many Appointment
    end
    an Appointment do
      one [Truck, Weighticket, Company]
      many [Batch, History, Picture]
    end
  end
  scope "/api", Apiv4 do
    pipe_through [:api, :auth, :account]
    the Report, [:create]
  end

  @moduledoc """
  requires user authentication
  """
  scope "/api", Apiv4 do
    pipe_through [:api, :auth]
    an Account, [:create, :show], do: one ServicePlan, [:show]
    an AccountDetail, [:show]
    the User, [:show, :update] do
      many [Account, Employee], [:index]
    end
    can_logout!
  end

  @moduledoc """
  anonymous api, no login required
  """
  scope "/api", Apiv4 do
    pipe_through :api
    
    the ServicePlan, [:index, :show]
    can_login!
  end

end

