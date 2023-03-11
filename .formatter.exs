[
  force_do_end_blocks: true,
  import_deps: [:phoenix, :plug],
  inputs: [
    ".{boundary,credo,dialyzer,formatter}.exs",
    "{config,lib,support,test}/**/*.{ex,exs,heex}",
    "mix.exs"
  ],
  line_length: 80,
  plugins: [Phoenix.LiveView.HTMLFormatter]
]
