defmodule Hw6.MixProject do
  use Mix.Project

  def project do
    [
      app: :hw_6,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      exqlite: "~> 0.27",
      ecto: "~> 3.10"
    ]
  end
end
