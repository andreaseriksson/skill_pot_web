defmodule SkillPot.Repo do
  use Ecto.Repo,
    otp_app: :skill_pot,
    adapter: Ecto.Adapters.Postgres
end
