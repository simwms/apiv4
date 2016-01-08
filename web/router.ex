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
    pipe_through [:api, :auth, :account, :management]
    the Camera, [:create, :update, :delete]
    the Tile, [:create, :delete]
    the Line, [:create, :update, :delete]
    the Employee, [:create, :delete]
    an Account, [:delete, :update] do
      one ServicePlan, [:create, :delete]
    end
  end

  @moduledoc """
  requires user account authentication
  """
  scope "/api", Apiv4 do
    pipe_through [:api, :auth, :account]
    the Camera, [:index, :show]
    the Point
    the Line, [:show, :index]
    the Truck do
      many [History, Picture]
    end
    the Weighticket
    the Batch do
      many [History, Picture]
    end
    the Employee, [:show, :index, :update] do
      many [History, Picture]
    end
    an Appointment do
      one [Truck, Weighticket]
      many [Batch, History, Picture]
    end
  end

  scope "/api", Apiv4 do
    pipe_through [:api, :echo, :auth, :account]
    the Report, [:create]
  end

  scope "/api", Apiv4 do
    pipe_through [:api, :auth, :account, :paranoia, :realtime]
    the Tile, [:show, :index, :update] do
      many [OnsiteTruck, OnsiteBatch, Employee]
    end
    the OnsiteTruck
    the LiveAppointment
  end

  @moduledoc """
  requires user authentication
  """
  scope "/api", Apiv4 do
    pipe_through [:api, :auth]
    an Account, [:create, :show] do
      many [Camera, Tile, Point, Line, Truck, Weighticket, Batch, Employee, Picture, Appointment], [:index]
      many [LiveAppointment, OnsiteBatch, OnsiteTruck], [:index]
      one [AccountDetail, ServicePlan], [:show]
    end
    an AccountDetail, [:show]
    the User, [:show, :update] do
      many Account
      many Employee, [:index]
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
